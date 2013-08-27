# cookbook Name:: srtg_core
#
# Copyright Infranics, Inc. All rights reserved.  All access and use subject to the
# Infranics Terms of Service available at http://www.infranics.com and,
# if applicable, other agreements such as a Infranics Master Subscription Agreement.

# Stop apache
action :stop do
  log "  Running stop SRTG-CORE All Service"
  service "SysMaster70d" do
    action :start
    persist false
  end
end

# Start apache
action :start do
  log "  Running start SRTG-CORE All Service"
  service "SysMaster70d" do
    action :start
    persist false
  end
end

# Restart apache
action :restart do
  action_stop
  sleep 5
  action_start
end
