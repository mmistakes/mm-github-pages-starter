# frozen_string_literal: true

# Hack ...or stub Liquid classes and methods used in plugin
module Liquid
  class Tag
    def initialize(*_); end
  end

  class Template
    def self.register_tag(*_); end
  end
end
