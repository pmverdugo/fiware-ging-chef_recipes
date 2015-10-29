#
# Cookbook Name:: fiware-idm
# Recipe:: install
#
# Copyright 2015, GING, ETSIT, UPM
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


INSTALL_DIR = "#{node['fiware-idm'][:install_dir]}"

include_recipe 'fiware-idm::stop'
include_recipe 'fiware-idm::uninstall'

python_runtime '2' do
  version '2.7'
  options :system, dev_package: true
end

# Checking OS compatibility for idm
if node['platform'] != 'ubuntu'
  log '*** Sorry, but the chef validator requires a ubuntu OS ***'
end
return if node['platform'] != 'ubuntu'

# fix source
bash :fix_source do
  code <<-EOH
    rm /bin/sh && ln -s /bin/bash /bin/sh
  EOH
end

# Update the sources list
include_recipe 'apt'

git INSTALL_DIR do
  repository 'https://github.com/ging/fiware-idm'
  action :sync
  timeout 3600
end

pip_requirements INSTALL_DIR+'/requirements.txt'

include_recipe 'fiware-idm::configure'

include_recipe 'fiware-idm::start'