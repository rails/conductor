require 'test_helper'

module Conductor
  class FixtureTest < ActiveSupport::TestCase
    def test_fixture_content 
      fixture = Conductor::Fixture.new(Rails.root.join("test", "fixtures","users.yml"))
      assert_match /firstname: MyString/, fixture.content
    end
  end
end