bash :set_dependencies do
  code <<-EOH
    sudo add-apt-repository ppa:chris-lea/node.js -y && \
    sudo apt-get update && \
    sudo apt-get install make g++ software-properties-common python-software-properties nodejs git -y
  EOH
end

bash :get_system do
  apppath = File.join(node.default[:app_dir], node.default[:app_name])
  code <<-EOH
    cd #{node.default[:app_dir]}
    sudo git clone https://github.com/ging/#{node.default[:app_name]}.git && \
    cd  #{apppath}&& \
    sudo npm install &&\
    sudo cp config.js.template config.js
    sudo node server.js
    EOH
  end