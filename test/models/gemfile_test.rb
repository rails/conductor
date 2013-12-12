require 'test_helper'

module Conductor
  class GemfileTest < ActiveSupport::TestCase
    def test_gemfile 
      assert_match(/"https:\/\/rubygems.org"/, Gemfile.instance.to_s)
    end
    def test_gemfile_change
      gemfile = Gemfile.instance
      content = gemfile.to_s
      gemfile.content = '# edit existing Gemfile'
      gemfile.save
      assert_match(/# edit existing Gemfile/, gemfile.content)
    ensure
      # restore the old content of the file
      File.open(Rails.root.join("Gemfile"), 'w') { |file| file.write(content) }
    end
  end
end