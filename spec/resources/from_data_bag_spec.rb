# frozen_string_literal: true

#
# Cookbook:: codenamephp_users
# Spec:: from_data_bag
#
# Copyright:: 2020, CodenamePHP
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

require 'spec_helper'

describe 'codenamephp_users_from_data_bag' do
  platform 'debian' # https://github.com/chefspec/chefspec/issues/953

  step_into :codenamephp_users_from_data_bag

  before(:example) do
    stub_search('users', '*:*').and_return([])
  end

  context 'With minimal attributes' do
    recipe do
      codenamephp_users_from_data_bag 'Create users' do
        groups %w(chef sudo sysadmin)
      end
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates the groups' do
      expect(chef_run).to create_group('chef')
      expect(chef_run).to create_group('sudo')
      expect(chef_run).to create_group('sysadmin')
    end

    it 'creates the users' do
      stub_search('users', '*:*').and_return([{ 'some user' => 'some value' }])
      expect(chef_run).to create_users_manage('chef').with(users: [{ 'some user' => 'some value' }])
      expect(chef_run).to create_users_manage('sudo').with(users: [{ 'some user' => 'some value' }])
      expect(chef_run).to create_users_manage('sysadmin').with(users: [{ 'some user' => 'some value' }])
    end

    it 'does nothing when databag was not found' do
      stub_search('users', '*:*').and_raise(Chef::Exceptions::InvalidDataBagPath)

      expect(chef_run).to_not create_group('chef')
      expect(chef_run).to_not create_group('sudo')
      expect(chef_run).to_not create_group('sysadmin')

      expect(chef_run).to_not create_users_manage('chef')
      expect(chef_run).to_not create_users_manage('sudo')
      expect(chef_run).to_not create_users_manage('sysadmin')

      expect(chef_run).to write_log('Databag was not found').with(level: :debug)
    end
  end
end
