module Conductor
  class Code
    def initialize(path)
      @path = path
    end

    def content
      @content ||= File.open(Rail.root.join(@path)).read
    end

    def content=(new_content)
      @content = new_content unless new_content.blank?
    end

    def path
      @path
    end

    def save
      !!File.open(Rails.root.join(@path), 'w') { |file| file.write(@content) }
    end

    def self.find_by_path(_path=Rails.root)
      path = Pathname.new(_path)
      @dir = [[], []]
      @directories = Dir.entries(File.join("/",path)).sort{|a,b| a.downcase <=> b.downcase }
      @directories.each do |dir|
        if File.directory?(File.join("/",path,dir)) && dir != "." && dir != ".."
          @dir[0]<<File.join("/",path,dir)
        end
        if File.file?(File.join("/",path,dir))
          @dir[1]<<File.join("/",path,dir)
        end
      end       
      return @dir.flatten
    end
  end
end
