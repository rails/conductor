require 'test_helper'

module Conductor
  class GemfileTest < ActiveSupport::TestCase
    def test_gemfile 
      assert_equal File.open(Rails.root.join("Gemfile")).read , Gemfile.instance.to_s
    end
    def test_gemfile_change
      gemfile = Gemfile.instance
      content = gemfile.to_s
      gemfile.content = 'edit existing Gemfile'
      gemfile.save
      assert_match /edit existing Gemfile/, gemfile.content
      gemfile.content = content
      gemfile.save
    end
  end
end