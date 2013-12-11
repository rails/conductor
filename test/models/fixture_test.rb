require 'test_helper'

module Conductor
  class FixtureTest < ActiveSupport::TestCase
    def test_fixture_content
      fixture = Conductor::Fixture.new(Rails.root.join("test", "fixtures","users.yml"))
      assert_match(/firstname: MyString/, fixture.content)
    end

    def test_fixture_content_change
      path = Rails.root.join("test", "fixtures","users.yml")
      fixture = Conductor::Fixture.new(path)
      content = fixture.content
      fixture.content = '# edit existing fixture'
      fixture.save

      fixture = Conductor::Fixture.new(path)
      assert_match(/# edit existing fixture/, fixture.content)
    ensure
      # restore the old content of the file
      File.open(path, 'w') { |file| file.write(content) }
    end

    def test_fixture_list
      list = Conductor::Fixture.all
      assert list.include?("users.yml")
    end
  end
end
