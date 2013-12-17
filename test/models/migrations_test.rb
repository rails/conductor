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
    def test_migration_list
      @migration = Migrations.list.first
      assert_equal "20130827165249", @migration[:id]
      assert_equal "********** NO FILE **********", @migration[:name]
      assert_equal "up", @migration[:status]
    end  
  end
end
