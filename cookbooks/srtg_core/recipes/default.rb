#
# Cookbook Name:: srtg_core
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

rightscale_marker :begin


log "  Setting provider specific settings for SRTG core."

log "Loading File SRTG core..."  
remote_file "/tmp/SRTG_core.tar.gz" do    
    owner "root"    
    group "root"    
    mode "0644"    
    source "#{node[:srtg_core][:source]}"    
    checksum "#{node[:srtg_core][:source_sha256]}"  
end  

log "Unpacking SRTG core..."  
bash "untar_srtg_core" do
    user "root"
    cwd "/tmp"    
    code <<-EOM
        mkdir #{node[:srtg_core][:install_dir]}
        mv SRTG_core.tar.gz #{node[:srtg_core][:install_dir]}
        cd #{node[:srtg_core][:install_dir]}
        tar -zxf SRTG_core.tar.gz
        rm -f SRTG_core.tar.gz
        tar -xvf #{node[:srtg_core][:install_file]}
        mkdir -p #{node[:srtg_core][:install_dir]}/logs
        mkdir -p #{node[:srtg_core][:install_dir]}/SM-DATA
        chmod 774 #{node[:srtg_core][:install_dir]}/logs
        chmod 774 #{node[:srtg_core][:install_dir]}/SM-DATA
        ln -s #{node[:srtg_core][:install_dir]}/jdk1.6.0_43 #{node[:srtg_core][:java_dir]}
        ln -s #{node[:srtg_core][:install_dir]}/apache-tomcat-5.5.29 #{node[:srtg_core][:tomcat_dir]}
    EOM
    not_if { ::File.exists?("#{node[:srtg_core][:install_dir]}/bin") }  
end

template "#{node[:srtg_core][:install_dir]}/conf/portal.conf" do    
    source "portal.conf.erb"    
    variables({      
        :sysmaster_home => node[:srtg_core][:install_dir],      
        :master_ip      => node[:srtg_core][:master_ip],      
        :database_ip    => node[:srtg_core][:database_ip],      
        :database_port  => node[:srtg_core][:database_port],      
        :database_user  => node[:srtg_core][:database_user],      
        :database_pwd   => node[:srtg_core][:database_pwd],      
        :database_sid   => node[:srtg_core][:database_sid]
    })  
end

template "#{node[:srtg_core][:install_dir]}/conf/config/framework/applicationContext-datasource.xml" do
    source "applicationContext-datasource.xml.erb"
    variables({
        :database_ip    => node[:srtg_core][:database_ip],
        :database_port  => node[:srtg_core][:database_port],
        :database_user  => node[:srtg_core][:database_user],
        :database_pwd   => node[:srtg_core][:database_pwd],
        :database_sid   => node[:srtg_core][:database_sid]
    })
end

template "#{node[:srtg_core][:install_dir]}/conf/system.properties" do
    source "system.properties.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/setJavaInstallEnv" do
    source "setJavaInstallEnv.erb"
    variables({
        :java_home => node[:srtg_core][:java_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/setSysMasterInstallEnv" do
    source "setSysMasterInstallEnv.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/setTomcatInstallEnv" do
    source "setTomcatInstallEnv.erb"
    variables({
        :tomcat_home => node[:srtg_core][:tomcat_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/sm70StartAll.sh" do
    source "sm70StartAll.sh.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/sm70StopAll.sh" do
    source "sm70StopAll.sh.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/bin/setAllEnv.sh" do
    source "setAllEnv.sh.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/tomcat5.5/conf/server.xml" do
    source "server.xml.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

template "#{node[:srtg_core][:install_dir]}/tomcat5.5/bin/catalina.sh" do
    source "catalina.sh.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir],
        :java_home => node[:srtg_core][:java_dir]
    })
end

template "/etc/init.d/SysMaster70d" do
    source "SysMaster70d.erb"
    variables({
        :sysmaster_home => node[:srtg_core][:install_dir]
    })
end

log "install SRTG core..."
bash "install_something" do
    user "root"
    cwd "/tmp"
    code <<-EOM
        chmod +x #{node[:srtg_core][:install_dir]}/bin/sm70StartAll.sh
        chmod +x #{node[:srtg_core][:install_dir]}/bin/sm70StopAll.sh
        chmod +x #{node[:srtg_core][:install_dir]}/bin/setAllEnv.sh
        chmod +x #{node[:srtg_core][:install_dir]}/tomcat5.5/bin/catalina.sh
        chmod +x /etc/init.d/SysMaster70d
        ln -s /etc/init.d/SysMaster70d /etc/rc2.d/S99SysMaster70d
        ln -s /etc/init.d/SysMaster70d /etc/rc3.d/S99SysMaster70d
        ln -s /etc/init.d/SysMaster70d /etc/rc5.d/S99SysMaster70d
        ln -s /etc/init.d/SysMaster70d #{node[:srtg_core][:install_dir]}/bin/SysMaster70d
        chmod +x #{node[:srtg_core][:install_dir]}/bin/*.sh
        chown -R root #{node[:srtg_core][:install_dir]}
        chgrp -R sys #{node[:srtg_core][:install_dir]}
    EOM
end

rightscale_marker :end
