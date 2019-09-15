# frozen_string_literal: true

module Jekyll
  class Command
    class << self
      #
      # patch original method to inject a '--show-data' switch to display
      # merged data hash
      #
      alias_method :original_build_options, :add_build_options

      def add_build_options(cmd)
        original_build_options(cmd)
        cmd.option "show-data", "--show-data",
                   "Print merged site-data hash when used with --verbose."
      end
    end
  end
end
