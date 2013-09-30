#
# Cookbook Name:: srtg_core
#
# Copyright Infranics, Inc. All rights reserved.  All access and use subject to the
# Infranics Terms of Service available at http://www.infranics.com and,
# if applicable, other agreements such as a Infranics Master Subscription Agreement.

# Optional attributes
default[:srtg_core][:source]           = "https://s3-ap-southeast-1.amazonaws.com/srtgtest/SysMaster70_7.0.0.0.1_ubuntu-12.04.tar.gz"
default[:srtg_core][:source_sha256]    = "0c7c1f2603b53ab8c9ebdb9881c4a833aad7852b23dc650df5216b468fe914a8"

# install attributes
default[:srtg_core][:master_ip]        = node[:cloud][:public_ips][0]
default[:srtg_core][:install_dir]      = "/usr/SysMaster70"
default[;srtg_core][:java_dir]         = "/usr/SysMaster70/jdk1.6"
default[:srtg_core][:tomcat_dir]       = "/usr/SysMaster70/tomcat5.5"
default[:srtg_core][:install_file]     = "SysMaster70_Linux*.tar"

# database attributes
default[:srtg_core][:database_port]    = "1521"
default[:srtg_core][:database_user]    = "uma"
default[:srtg_core][:database_pwd]     = "master"
default[:srtg_core][:database_sid]     = "uma"
