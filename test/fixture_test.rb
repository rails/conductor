require 'test_helper'
module Conductor
  class FixtureTest < ActiveSupport::TestCase
   
    def test_fixture_content 
      f=Conductor::Fixture.new(Rails.root.join("test", "fixtures","users.yml"))
      c=File.open(Rails.root.join("test", "fixtures","users.yml")).read
      assert_equal f.content, c
    end

  end
end