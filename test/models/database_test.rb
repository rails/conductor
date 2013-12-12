require 'test_helper'

module Conductor
  class DatabaseTest < ActiveSupport::TestCase
    def test_database 
      assert_match(/# SQLite version 3.x/, Database.instance.to_s)
    end
    def test_database_change
      database = Database.instance
      content = database.to_s
      database.content = '# edit existing Database file'
      database.save
      assert_match(/# edit existing Database file/, database.content)
    ensure
      # restore the old content of the file
      File.open(Rails.root.join("config","database.yml"), 'w') { |file| file.write(content) }
    end
  end
end