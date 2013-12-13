require 'test_helper'

module Conductor
  class MigrationTest < ActiveSupport::TestCase
    def test_migrations
      #ActiveRecord::Migrator.stub(:schema_migrations_table_name).returns("AnyName")
      assert_raise (Conductor::Migrations::MigrationError) do 
        Migrations.list
      end
    end
  end
end