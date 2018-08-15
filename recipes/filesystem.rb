#
# Cookbook:: centos7-baseline
# Recipe:: filesystem
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
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
execute "create_modprobd+folder" do
    command "sudo mkdir -p /etc/modprobe.d/"                
end
execute "remove_config" do
    command "sudo rm -f /etc/modprobe.d/dev-sec.conf"                
end

node['filesystems'].each do |filesystem|
    execute "create_cis_conf_add_#{filesystem}" do
        command "rmmod #{filesystem}"                       
        only_if "lsmod | grep #{filesystem}"
    end    
    execute "create_cis_conf_add_#{filesystem}" do
        command "sudo echo 'install #{filesystem} /bin/true' >> /etc/modprobe.d/dev-sec.conf"
    end    
end
