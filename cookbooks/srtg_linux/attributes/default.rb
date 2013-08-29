#
# Cookbook Name:: srtg_core
#
# Copyright Infranics, Inc. All rights reserved.  All access and use subject to the
# Infranics Terms of Service available at http://www.infranics.com and,
# if applicable, other agreements such as a Infranics Master Subscription Agreement.

# Optional attributes
default["srtg_linux"]["source"]           = "https://s3-ap-southeast-1.amazonaws.com/srtgtest/InfraUma_7.0.5_Linux2.6x64.tar"
default["srtg_linux"]["source_sha"]       = "8837e46fb97fe10180dd923a246bca72ecce5da4"

default["srtg_linux"]["agent_version"]    = "7.0.5"
default["srtg_linux"]["installed_osvervion"]    = "Linux2.6x64"
default["srtg_linux"]["host_name"]        = "Linux2.6x64"
default["srtg_linux"]["install_dir"]      = "/usr/infrauma"
default["srtg_linux"]["data_dir"]         = "/usr/infrauma/agent/data"
default["srtg_linux"]["install_file"]     = "infrauma_agent*"

# Set Master Server
default["srtg_linux"]["data_port"]        = "9602"
default["srtg_linux"]["event_port"]       = "9603"
default["srtg_linux"]["mcc_port"]         = "9606"
default["srtg_linux"]["realtime_port"]    = "9615"
default["srtg_linux"]["shell_port"]       = "9616"
default["srtg_linux"]["realtime_period"]  = "5"

# Set agent client
default["srtg_linux"]["agent_ip"]         = node[:cloud][:public_ips][0]
default["srtg_linux"]["agent_port"]       = "9601"
default["srtg_linux"]["control_port"]     = "9611"
default["srtg_linux"]["temp_dir"]         = "/tmp"
