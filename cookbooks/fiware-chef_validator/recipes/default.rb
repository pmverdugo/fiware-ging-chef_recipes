#
# Cookbook Name::
# Recipe:: install
#
# Copyright 2013-2015, CoNWeT Lab., Universidad Politécnica de Madrid
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

require 'rubygems'
include_recipe 'build-essential'

# case node['platform-family']
#   when 'ubuntu'
#     include_recipe ''


dependencies = value_for_platform_family(
                   'ubuntu' => ['dep1', 'dep2'],
)

dependencies.each do ||
bash :set_dependencies do
  code <<-EOH
    sudo add-apt-repository ppa:chris-lea/node.js -y && \
    sudo apt-get update && \
    sudo apt-get install make g++ software-properties-common python-software-properties nodejs git -y
  EOH
end

bash :get_system do
  code <<-EOH
    cd /opt && \
    sudo git clone https://github.com/ging/fiware-chef_validator.git && \
    cd  #{node['fiware-chef_validator'][:app_dir]}&& \
    sudo npm install &&\
    sudo cp config.js.template config.js
    EOH
  end