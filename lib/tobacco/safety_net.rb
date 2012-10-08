# Backup is responsible for backing up the current file
# if it exists and restoring it in the event an error
# occurs while attempting to write new content.
#
module Tobacco
  class SafetyNet
    attr_reader :file

    def initialize(filepath)
      @filepath = filepath
    end

    # Public: Creates a backup of the original file
    #         so it can be restored if necessary
    #
    def backup
      Tobacco.log("Backup: #{@filepath} => #{destination}")

      if File.exists? @filepath
        FileUtils.mv(@filepath, destination)
      end
    end

    # Public: Restores the original file in
    #         the event an error occurs during
    #         writing the new content
    #
    def restore
      Tobacco.log("Restoring: #{destination} => #{@filepath}")

      if File.exists? destination
        FileUtils.mv(destination, @filepath)
      end
    end

    # Public: Destroys the backup file
    #
    def destroy
      Tobacco.log("Destroying: #{destination}")

      if File.exists? destination
        FileUtils.rm(destination)
      end
    end

    # Public: Memoizes the destination path
    #
    def destination
      @destination ||= destination_path
    end

    private

    # Private: Creates a temporary path with
    #          a unique name using a timestamp
    #
    def destination_path
      name     = File.basename @filepath
      dir      = File.dirname @filepath
      additive = Time.now.to_i
      temp_name = "#{additive}_#{name}"

      "#{dir}/#{temp_name}"
    end
  end
end
