# frozen_string_literal: true

# oh well ... https://github.com/apalmblad/ruby-shadow/issues/26
# chef_gem 'ruby-shadow' do # purge the gem since it is not included in all installs so we need to test the install in the resource
#  action :purge
# end

codenamephp_users_from_data_bag 'Create users' do
  groups %w(chef sudo sysadmin)
end
