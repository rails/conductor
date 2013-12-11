require 'test_helper'

module Conductor
  class CodeStatisticsTest < ActiveSupport::TestCase
    def setup
      @stats = Conductor::CodeStatistics.new(['Models', 'app/models'], ['Controllers', 'app/controllers'])
    end

    def test_lines
      assert 2, @stats.lines.size
      assert 'Models', @stats.lines[0][:name]
      assert 'Controllers', @stats.lines[1][:name]
    end

    def test_line
      models = @stats.lines.first

      assert 'Models', models[:name]
      assert 222, models[:lines]
      assert 179, models[:codelines]
      assert 7, models[:classes]
      assert 26, models[:methods]
      assert 3, models[:m_over_c]
      assert 4, models[:loc_over_m]
    end

    def test_total_line
      total = @stats.total_line

      assert "Total", total[:name]
      assert 527, total[:lines]
      assert 428, total[:codelines]
      assert 22, total[:classes]
      assert 57, total[:methods]
      assert 2, total[:m_over_c]
      assert 5, total[:loc_over_m]
    end
  end
end
