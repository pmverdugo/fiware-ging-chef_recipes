#
# Cookbook Name:: fiware-idm
# Recipe:: start
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

INSTALL_DIR = node['fiware-idm'][:install_dir]
ENV['PYTHONPATH'] = "#{ENV['PYTHONPATH']}:#{INSTALL_DIR}/idm"

bash 'start idm' do
  environment 'PYTHONPATH' => "#{INSTALL_DIR}/idm:#{ENV['PYTHONPATH']}"
  cwd "#{INSTALL_DIR}"
  user 'root'
  code <<-EOH
    python ./idm/cmd/chef-validator-api.py --config-dir=etc/idm &
  EOH
end