#
# Cookbook Name:: bork
# Recipe:: configure
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

INSTALL_DIR = node['bork'][:install_dir]

## Creating bork config file
template "#{INSTALL_DIR}/etc/chef_validator/chef_validator.conf" do
  source 'bork.conf.erb'
  owner 'root'
  group 'root'
  mode  0755
end