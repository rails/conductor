require 'test_helper'

module Conductor
  class DatabaseTest < ActiveSupport::TestCase
    def test_database 
      assert_equal File.open(Rails.root.join('config','database.yml')).read , Database.instance.to_s
    end
    def test_database_change
      database = Database.instance
      content = database.to_s
      database.content = 'edit existing Database file'
      database.save
      assert_match /edit existing Database file/, database.content
      database.content = content
      database.save
    end
  end
end