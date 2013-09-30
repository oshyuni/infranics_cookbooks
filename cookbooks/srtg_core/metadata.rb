name             'srtg_core'
maintainer       'Infranics, Inc.'
maintainer_email 'YOUR_EMAIL'
license          'Copyright Infranics, Inc. All rights reserved.'
description      'Installs/Configures srtg_core'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '7.0.0'

#supports "ubuntu", "~> 12.04.0"

depends "rightscale"

recipe  "srtg_core::default", "Installs the SRTG server."

# Required Input #
attribute "srtg_core/database_ip",
    :display_name => "Database IP",
    :description => "The Database IP address is SRTG core.",
    :required => "required",
    :recipes => ["srtg_core::default"]
