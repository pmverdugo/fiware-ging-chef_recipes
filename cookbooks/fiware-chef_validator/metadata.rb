name 'fiware-chef_validator'
description 'A cookbook for deploying the fiware-chef_validator component'
version '1.0.0'

%w{ debian ubuntu }.each do |os|
  supports os
end