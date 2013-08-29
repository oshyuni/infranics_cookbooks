name             'srtg_linux'
maintainer       'Infranics, Inc'
maintainer_email 'oshyuni@infranics.com'
license          'Infranics, Inc.All rights reserved'
description      'Installs/Configures srtg_linux'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '7.0.5'

supports "centos", "~> 4.6"

depends "rightscale"

recipe  "srtg_linux::default", "Installs the SRTG linux agent."

# Required Input #
attribute "srtg_linux/master_ip",
    :display_name => "Master IP",
    :description => "The Master IP address of SRTG agent.",
    :required => "required",
    :recipes => ["srtg_linux::default"]

