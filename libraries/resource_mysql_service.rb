require 'chef/resource/lwrp_base'
require_relative 'helpers'

class Chef
  class Resource
    class MysqlService < Chef::Resource::LWRPBase
      self.resource_name = :mysql_service
      actions :create, :restart, :reload
      default_action :create

      attribute :allow_remote_root, :kind_of => [TrueClass, FalseClass], :default => false
      attribute :data_dir, :kind_of => String, :default => nil
      attribute :package_name, :kind_of => String, :default => nil
      attribute :port, :kind_of => String, :default => '3306'
      attribute :remove_anonymous_users, :kind_of => [TrueClass, FalseClass], :default => true
      attribute :remove_test_database, :kind_of => [TrueClass, FalseClass], :default => true
      attribute :root_network_acl, :kind_of => Array, :default => []
      attribute :server_debian_password, :kind_of => String, :default => 'gnuslashlinux4ev4r'
      attribute :server_repl_password, :kind_of => String, :default => nil
      attribute :server_root_password, :kind_of => String, :default => 'ilikerandompasswords'
      attribute :service_name, :kind_of => String, :name_attribute => true
      attribute :template_source, :kind_of => String, :default => nil
      attribute :version, :kind_of => String, :default => nil
      attribute :package_version, :kind_of => String, :default => nil
      attribute :package_action, :kind_of => String, :default => nil
    end

    include Opscode::Mysql::Helpers

    def parsed_allow_remote_root
      return allow_remote_root unless allow_remote_root.nil?
    end

    def parsed_data_dir
      return data_dir if data_dir
      default_data_dir_for(node['platform_family'])
    end

    def parsed_package_name
      return package_name if package_name
      package_name_for(
        node['platform'],
        node['platform_family'],
        node['platform_version'],
        parsed_version
        )
    end

    def parsed_package_version
      return package_version if package_version
    end

    def parsed_package_action
      return package_action if package_action
    end

    def parsed_port
      return port if port
    end

    def parsed_remove_anonymous_users
      return remove_anonymous_users unless remove_anonymous_users.nil?
    end

    def parsed_remove_test_database
      return remove_test_database unless remove_test_database.nil?
    end

    def parsed_root_network_acl
      return root_network_acl if root_network_acl
    end

    def parsed_server_debian_password
      return server_debian_password if server_debian_password
    end

    def parsed_server_repl_password
      return server_repl_password if server_repl_password
    end

    def parsed_server_root_password
      return server_root_password if server_root_password
    end

    def parsed_service_name
      return service_name if service_name
    end

    def parsed_template_source
      return template_source if template_source
    end

    def parsed_version
      return version if version
      default_version_for(
        node['platform'],
        node['platform_family'],
        node['platform_version']
        )
    end
  end
end
