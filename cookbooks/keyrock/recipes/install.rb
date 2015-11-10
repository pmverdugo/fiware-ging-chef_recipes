#
# Cookbook Name:: keyrock
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

include_recipe 'git::default'

INSTALL_DIR = node['keyrock'][:install_dir]

include_recipe 'keyrock::stop'
include_recipe 'keyrock::uninstall'

# Checking OS compatibility for idm
if node['platform'] != 'ubuntu'
  log '*** Sorry, but the fiware idm requires a ubuntu OS ***'
end
return if node['platform'] != 'ubuntu'

package 'git' do
  action :install
end

git INSTALL_DIR do
  repository 'https://github.com/ging/fiware-idm'
  action :sync
  timeout 3600
  user 'root'
end

include_recipe 'keyrock::configure'

python_runtime '2' do
  version '2.7'
  options :system, dev_package: true
end

python_virtualenv INSTALL_DIR+'idm_tools' do
  user 'root'
  path INSTALL_DIR+'/idm_tools'
end

pip_requirements INSTALL_DIR+'/requirements.txt' do
  virtualenv INSTALL_DIR+'idm_tools'
end

bash 'fab_magic' do
  user 'root'
  cwd INSTALL_DIR
  code <<-EOH
    source idm_tools/bin/activate
    fab keystone.install &
    fab horizon.install &
  EOH
end

include_recipe 'keyrock::start'