require 'test_helper'

module Conductor
  class MigrationTest < ActiveSupport::TestCase
    def test_migration_fail_when_schema_migration_does_not_exist
      connection_mock = Object.new
      def connection_mock.table_exists?(*) false end

      ActiveRecord::Base.stub :connection, connection_mock do
        assert_raise(Conductor::Migrations::MigrationError) do
          Migrations.list
        end
      end
    end
  end
end
