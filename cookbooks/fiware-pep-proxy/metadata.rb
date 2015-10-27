name 'fiware-pep-proxy'
maintainer        'GING-DIT-ETSIT-UPM'
maintainer_email  'ging@dit.upm.es'
description       'A cookbook for deploying the fiware-pep-proxy component'
version           '0.0.1'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))

depends           'git'
depends           'apt'

%w{ ubuntu }.each do |os|
  supports os
end