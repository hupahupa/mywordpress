#
# Cookbook Name:: wordpress
# Recipe:: database
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Copyright (C) 2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#



db = node[:mywordpress][:db]

#create user
username = db[:username]
password = db[:password]
host = 'localhost'
root_password = node[:mysql][:server_root_password]

bash "create user #{username}" do
    code <<-EOH
mysql -uroot -p#{root_password} <<EOF
GRANT USAGE ON *.* TO '#{username}'@'#{host}';
EOF
    EOH
end

bash "set password for #{username}" do
    code <<-EOH
mysql -uroot -p#{root_password} <<EOF
UPDATE mysql.user SET password = PASSWORD('#{password}') where user = '#{username}';
FLUSH PRIVILEGES;
EOF
    EOH
    only_if { password }
end

#create db
db_name = db[:database]
owner = db[:username]
host = 'localhost'
root_password = node[:mysql][:server_root_password]

bash "create database #{db_name}" do
    code <<-EOH
mysql -uroot -p#{root_password} <<"EOF"
CREATE DATABASE IF NOT EXISTS `#{db_name}`;
ALTER DATABASE #{db_name} CHARACTER SET utf8;
GRANT ALL ON `#{db_name}`.* TO '#{owner}'@'#{host}';
FLUSH PRIVILEGES;
EOF
    EOH
end