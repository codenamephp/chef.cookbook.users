# frozen_string_literal: true

name 'codenamephp_users'
maintainer 'Bastian Schwarz'
maintainer_email 'bastian@codename-php.de'
license 'Apache-2.0'
description 'Cookbook to install apache2'
version '1.0.1'
chef_version '>= 15.3'
issues_url 'https://github.com/codenamephp/chef.cookbook.users/issues'
source_url 'https://github.com/codenamephp/chef.cookbook.users'

supports 'debian'

depends 'users', '~> 8.0'
