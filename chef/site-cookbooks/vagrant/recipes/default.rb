include_recipe 'main'

# db = node[:mywordpress][:db]

# bash 'import database' do
#     code <<-EOH
#         mysql -u#{db[:username]} -p#{db[:password]} #{db[:database]} < /vagrant/dump.sql
#     EOH
# end