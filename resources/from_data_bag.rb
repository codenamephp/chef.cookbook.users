unified_mode true

property :groups, Array, description: 'The groups to manage users for'
property :data_bag_name, String, default: 'users', description: 'The name of the databag to get the users from'
property :data_bag_query, String, default: '*:*', description: 'The query that is used when searching the databag'

action :create do
  begin
    users_from_databag = search(new_resource.data_bag_name, new_resource.data_bag_query)

    new_resource.groups.each do |group_name|
      group group_name do
        append true
      end

      users_manage group_name do
        users users_from_databag
      end
    end
  rescue Net::HTTPServerException, Chef::Exceptions::InvalidDataBagPath
    log "Databag '#{new_resource.data_bag_name}' with query '#{new_resource.data_bag_query}' was not found" do
      level :debug
    end
  end
end
