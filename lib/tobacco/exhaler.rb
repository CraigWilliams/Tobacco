require 'fileutils'

module Tobacco
  class Exhaler
    attr_accessor :content, :filepath

    def initialize(content = '', filepath = '')
      self.content = content
      self.filepath = filepath
    end

    def write!
     # safety_net.backup

     create_directory
     write_content_to_file
    end

    def create_directory
      dir = File.dirname(filepath)

      FileUtils.mkdir_p dir
      File.chmod(0775, dir)
    end

    def write_content_to_file
      begin
        persist(content)
        # safety_net.destroy
      rescue => e
        # safety_net.restore
        raise
      end
    end


    private

    def persist(file_content)
      File.open(filepath, 'wb') do |f|
        f.write file_content
      end

      File.chmod(0644, filepath)
    end

    def safety_net
      @safety_net ||= Tobacco::SafetyNet.new(filepath)
    end
  end
end
