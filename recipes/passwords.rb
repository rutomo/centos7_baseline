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

bash 'update_login_defs' do
    code <<-EOH
    sed -i 's/^PASS_MAX_DAYS.*/PASS_MAX_DAYS     60/pI' /etc/login.defs
    sed -i 's/^PASS_MIN_DAYS.*/PASS_MIN_DAYS     7/pI' /etc/login.defs
    echo "LOGIN_TIMEOUT 60" >> /etc/login.defs
    echo "LOGIN_RETRIES 5" >> /etc/login.defs
    echo "ENV_SUPATH PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" >> /etc/login.defs
    echo "ENV_PATH PATH=/usr/local/bin:/usr/bin:/bin" >> /etc/login.defs
    chmod 444 /etc/login.defs
    rm -f /usr/libexec/openssh/ssh-keysign
    EOH
end
