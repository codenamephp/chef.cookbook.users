# Chef Cookbook
[![CI](https://github.com/codenamephp/chef.cookbook.users/actions/workflows/ci.yml/badge.svg)](https://github.com/codenamephp/chef.cookbook.users/actions/workflows/ci.yml)

A wrapper for the [sous chefs users cookbook][sc_users] that adds a resource to add users directly from a databag.
## Usage

Add the cookbook to your wrapper cookbook and use the resource. Also make sure you actually include the data_bag otherwise the resource does nothing.

## Resources
### from_data_bag
The `codenamephp_from_data_bag` Resource wraps the loading of the databage, creating of groups and the users_manage call that creates the users. The groups
are created first so the users are corrctly added.

If the data_bag was not found or was invalid the creation is skipped and a message is logged.

#### Actions
- `:create`: Manages the users. Desipite the action name users can also be removed if they are marked in the data_bag

#### Properties
- `groups`: Array of group names to manage. If a group does not exist it is created before users_manage is called
- `data_bag_name`: The name of the data_bag to load the users from, defaults to `'users'`
- `data_bag_query`: The query that is used to load the data_bag_items, defaults to `'*:*'`

#### Examples
```ruby
# Minimal properties
codenamephp_users_from_data_bag 'Create users' do
  groups %w(chef sudo sysadmin)
end

# With custom data_bag and query
codenamephp_users_from_data_bag 'Create users' do
  groups %w(extra)
  data_bag_name 'extra_users'
  data_bag_query 'groups:*extra*'
end
```

[sc_users]: https://github.com/sous-chefs/users