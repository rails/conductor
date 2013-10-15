require 'singleton'

module Conductor
  class Migrations
    class MigrationError < StandardError;end

    def self.list
      unless ActiveRecord::Base.connection.table_exists?(ActiveRecord::Migrator.schema_migrations_table_name)
        raise MigrationError.new('Schema migrations table does not exist yet.')
      end

      db_list = ActiveRecord::Base.connection.select_values("SELECT version FROM #{ActiveRecord::Migrator.schema_migrations_table_name}")
      db_list.map! { |version| "%.3d" % version }
      file_list = []
      ActiveRecord::Migrator.migrations_paths.each do |path|
        Dir.foreach(path) do |file|
          # match "20091231235959_some_name.rb" and "001_some_name.rb" pattern
          if match_data = /^(\d{3,})_(.+)\.rb$/.match(file)
            status = db_list.delete(match_data[1]) ? 'up' : 'down'
            file_list << [status, match_data[1], match_data[2].humanize]
          end
        end
      end
      db_list.map! do |version|
        ['up', version, '********** NO FILE **********']
      end

      result = []
      (db_list + file_list).sort_by {|migration| migration[1]}.each do |migration|
        result << {
          id: migration[1],
          name: migration[2],
          status: migration[0]
        }
      end

      result
    end

    def self.to_version(direction, version)
      ActiveRecord::Migrator.run(direction, ActiveRecord::Migrator.migrations_paths, version.to_i)
      true
    rescue => e
      raise MigrationError.new(e.message)
    end
  end
end
