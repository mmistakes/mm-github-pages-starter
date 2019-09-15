# frozen_string_literal: true

require "jekyll"
require "jekyll-data/version"

module JekyllData
  autoload :Reader,             "jekyll-data/reader"
  autoload :ThemedSiteDrop,     "jekyll-data/themed_site_drop"
  autoload :ThemeDataReader,    "jekyll-data/theme_data_reader"
  autoload :ThemeConfiguration, "jekyll-data/theme_configuration"
end

# Monkey-patches
require_relative "jekyll/build_options"
require_relative "jekyll/data_path"
require_relative "jekyll/theme_drop"

# ----------------------------------------------------------------------------
# Modify the current site instance only if it uses a gem-based theme.
#
# if a '_config.yml' is present at the root of theme-gem, it is evaluated and
# the extracted hash data is incorprated into the site's config hash.
#
# *Jekyll 4.0 has this feature incorporated in its core.*
# ----------------------------------------------------------------------------
unless Jekyll::VERSION.start_with?("4")
  Jekyll::Hooks.register :site, :after_reset do |site|
    if site.theme
      file = site.in_theme_dir("_config.yml")
      JekyllData::ThemeConfiguration.reconfigure(site) if File.exist?(file)
    end
  end
end

# ---------------------------------------------------------------------------
# Replace Jekyll::Reader with a subclass JekyllData::Reader only if the
# site uses a gem-based theme.
#
# If a _config.yml exists at the root of the theme-gem, output its path.
# Placed here inorder to avoid outputting the path after every regeneration.
#
# *Jekyll 4.0 detects a theme-configuration natively.*
# ---------------------------------------------------------------------------
Jekyll::Hooks.register :site, :after_init do |site|
  if site.theme
    unless Jekyll::VERSION.start_with?("4")
      file = site.in_theme_dir("_config.yml")
      Jekyll.logger.info "Theme Config file:", file if File.exist?(file)
    end
    site.reader = JekyllData::Reader.new(site)
  end
end
