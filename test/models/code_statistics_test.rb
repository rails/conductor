require 'test_helper'

module Conductor
  class CodeStatisticsTest < ActiveSupport::TestCase
    def setup
      @stats = Conductor::CodeStatistics.new(['Models', 'app/models'], ['Controllers', 'app/controllers'])
    end

    def test_lines
      assert_equal 2, @stats.lines.size
      assert_equal 'Models', @stats.lines[0][:name]
      assert_equal 'Controllers', @stats.lines[1][:name]
    end

    def test_line
      models = @stats.lines.first

      assert_equal 'Models', models[:name]
      assert_equal 222, models[:lines]
      assert_equal 179, models[:codelines]
      assert_equal 7, models[:classes]
      assert_equal 26, models[:methods]
      assert_equal 3, models[:m_over_c]
      assert_equal 4, models[:loc_over_m]
    end

    def test_total_line
      total = @stats.total_line

      assert_equal "Total", total[:name]
      assert_equal 527, total[:lines]
      assert_equal 428, total[:codelines]
      assert_equal 22, total[:classes]
      assert_equal 57, total[:methods]
      assert_equal 2, total[:m_over_c]
      assert_equal 5, total[:loc_over_m]
    end

    def test_code_loc
      assert_equal 428, @stats.code_loc
    end

    def test_tests_loc
      assert_equal 0, @stats.tests_loc
    end

    def test_code_to_test
      assert_equal 0.0, @stats.code_to_test
    end
  end
end
