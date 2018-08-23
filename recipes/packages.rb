#
# Cookbook:: centos7-baseline
# Recipe:: packages
#
# Copyright:: 2018,  Rinaldi Utomo
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License

node['packages_to_install'].each do |package_name,service_name|
    package "#{package_name}" do
        action :install        
    end
    service "#{service_name}" do
        supports :status => false
        action :start        
    end    
end
bash 'update_auditd_configs' do
    code <<-EOH
    sed -i 's/^log_file.*/log_file = /var/log/audit/audit.log/pI' /etc/audit/auditd.conf
    sed -i 's/^log_format.*/log_format = raw/pI' /etc/audit/auditd.conf
    sed -i 's/^flush.*/flush = INCREMENTAL_ASYNC/pI' /etc/audit/auditd.conf
    sed -i 's/^max_log_file_action.*/max_log_file_action = keep_logs/pI' /etc/audit/auditd.conf
    EOH
end
