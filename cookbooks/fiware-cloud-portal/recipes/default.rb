bash :set_dependencies do
  code <<-EOH
    sudo add-apt-repository ppa:chris-lea/node.js -y && \
    sudo apt-get update && \
    sudo apt-get install make g++ software-properties-common python-software-properties nodejs git ruby1.9.1 -y && \
    sudo gem install sass -v 3.2.12 -y
  EOH
end

bash :get_system do
  code <<-EOH
    cd /opt
    sudo git clone https://github.com/ging/#{node[:app_name]}.git && \
    cd #{node[:app_dir]} && \
    sudo npm install && \
    ./node_modules/grunt-cli/bin/grunt && \
    sudo cp config.js.template config.js
    sudo node server.js
  EOH
end