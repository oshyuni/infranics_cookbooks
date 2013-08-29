#
# Cookbook Name:: srtg_linux
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin


log "  Setting provider specific settings for SRTG linux agent."

log "Loading File SRTG linux agent..."
remote_file "/tmp/SRTG_linux.tar" do
    owner "root"
    group "root"
    mode "0644"
    source "#{node[:srtg_linux][:source]}"
    checksum "#{node[:srtg_linux][:source_sha]}"
end

log "Unpacking SRTG linux agent..."
bash "untar_srtg_linux" do
    user "root"
    cwd "/tmp"
    code <<-EOM
        mkdir #{node[:srtg_linux][:install_dir]}
        mv SRTG_linux.tar #{node[:srtg_linux][:install_dir]}
        cd #{node[:srtg_linux][:install_dir]}
        tar -xvf SRTG_linux.tar
        rm -f SRTG_linux.tar
        tar -xvf #{node[:srtg_linux][:install_file]}
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/conf
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/err
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/restore
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/tmp
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/.pid
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/data
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/log
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/download
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/download/bin
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/download/conf
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/download/data
        mkdir -p #{node[:srtg_linux][:install_dir]}/agent/backup
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/conf
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/err
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/restore
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/tmp
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/.pid
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/data
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/log
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/download
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/download/bin
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/download/conf
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/download/data
        chmod 774 #{node[:srtg_linux][:install_dir]}/agent/backup

        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/scheduler.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/scheduler.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/dbagent.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/dbagent.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/cpu.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/cpu.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/memory.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/memory.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/disk.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/disk.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/swap.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/swap.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/daemon.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/daemon.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/path.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/path.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/config.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/config.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/log.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/log.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/process.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/process.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/tail.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/tail.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/sysmaster.tb.pre #{node[:srtg_linux][:install_dir]}/agent/data/sysmaster.tb
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/traceroute.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/traceroute.ini
        cp #{node[:srtg_linux][:install_dir]}/agent/_conf/swlist.ini.pre #{node[:srtg_linux][:install_dir]}/agent/conf/swlist.ini
    EOM
    not_if { ::File.exists?("#{node[:srtg_linux][:install_dir]}/agent") }
end

log "Setting agent.ini"
template "#{node[:srtg_linux][:install_dir]}/agent/conf/agent.ini" do
    source "agent.ini.erb"
    variables({
        :agent_version    => node[:srtg_linux][:agent_version],
        :install_dir      => node[:srtg_linux][:install_dir],
        :installed_osversion => node[:srtg_linux][:installed_osversion],
        :host_name        => node[:srtg_linux][:host_name],
        :master_ip        => node[:srtg_linux][:master_ip],
        :primary_ip       => node[:srtg_linux][:master_ip],
        :secondary_ip     => node[:srtg_linux][:master_ip],
        :data_port        => node[:srtg_linux][:data_port],
        :event_port       => node[:srtg_linux][:event_port],
        :mcc_port         => node[:srtg_linux][:mcc_port],
        :realtime_port    => node[:srtg_linux][:realtime_port],
        :shell_port       => node[:srtg_linux][:shell_port],
        :realtime_period  => node[:srtg_linux][:realtime_period],
        :control_port     => node[:srtg_linux][:control_port]
    })
end

log "Setting uma.ini"
template "#{node[:srtg_linux][:install_dir]}/agent/conf/uma.ini" do
    source "uma.ini.erb"
    variables({
        :agent_ip   => node[:srtg_linux][:agent_ip],
        :agent_port => node[:srtg_linux][:agent_port]
        :temp_dir   => node[:srtg_linux][:temp_dir]
    })
end

log "Setting infrauma.ini"
template "/etc/infrauma.ini" do
    source "infrauma.ini.erb"
    variables({
        :uma_home  => node[:srtg_linux][:install_dir]
    })
end

log "Setting init.d"
template "/etc/init.d/infraumad" do
    source "infraumad.erb"
    variables({
        :uma_home  => node[:srtg_linux][:install_dir]
    })
end

log "install SRTG core..."
bash "install_something" do
    user "root"
    cwd "/tmp"
    code <<-EOM
        chmod +x /etc/init.d/infraumad
        ln -s /etc/init.d/infraumad /etc/rc2.d/S99infraumad
        ln -s /etc/init.d/infraumad /etc/rc3.d/S99infraumad
        ln -s /etc/init.d/infraumad /etc/rc5.d/S99infraumad
        ln -s /etc/init.d/infraumad #{node[:srtg_linux][:install_dir]}/agent/infraumad
        chmod +x #{node[:srtg_linux][:install_dir]}/agent/bin/*
        chmod +s #{node[:srtg_linux][:install_dir]}/agent/bin/uma.listend
        chmod +s #{node[:srtg_linux][:install_dir]}/agent/bin/umaagent
        chown -R root #{node[:srtg_core][:install_dir]}
        chgrp -R sys #{node[:srtg_core][:install_dir]}
        ln -s #{node[:srtg_core][:install_dir]} /opt/infrauma
    EOM
end

action :start

rightscale_marker :end

