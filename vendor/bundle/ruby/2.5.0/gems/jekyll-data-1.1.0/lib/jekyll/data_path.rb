# frozen_string_literal: true

module Jekyll
  class Theme
    def data_path
      @data_path ||= path_for "_data"
    end
  end
end
