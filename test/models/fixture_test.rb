require 'test_helper'

module Conductor
  class FixtureTest < ActiveSupport::TestCase
    def test_fixture_content 
      fixture = Conductor::Fixture.new(Rails.root.join("test", "fixtures","users.yml"))
      assert_match /firstname: MyString/, fixture.content
    end
    def test_fixture_content_change
    	fixture = Conductor::Fixture.new(Rails.root.join("test", "fixtures","users.yml"))
    	content = fixture.content
    	fixture.content = 'edit existing fixture'
    	fixture.save
    	assert_match /edit existing fixture/, fixture.content
    	fixture.content = content
    	fixture.save
    end
    def test_fixture_list
    	list_test = Dir.chdir(Rails.root.join("test", "fixtures")) do
        	         Dir[File.join("**","*.yml")]
      		        end
      list = Conductor::Fixture.all
      assert_equal list_test , list
    end
  end
end