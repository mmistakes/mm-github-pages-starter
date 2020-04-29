# frozen_string_literal: true
# Basic integration example - run code to produce html output
#
$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require_relative "./support/jekyll_template"
require "jekyll-twitter-plugin"
require "erb"
require "byebug"

OUTPUT_FILENAME = "output_test.html"
OPTIONS = [
  "https://twitter.com/jekyllrb maxwidth=500 limit=5",
  "https://twitter.com/rubygems",
  "https://twitter.com/i/moments/650667182356082688 maxwidth=500",
  "https://twitter.com/TwitterDev/timelines/539487832448843776 limit=5 widget_type=grid maxwidth=500",
  "https://twitter.com/rubygems/status/518821243320287232",
  "https://twitter.com/rubygems/status/11",
  "https://twitter.com/rubygems/status/518821243320287232 align=right width=350",
  "https://twitter.com/Ace_Tate/status/225611299009216512",
  "https://twitter.com/FeelsGood2BeMe/status/225456333032398848",
  "oembed https://twitter.com/rubygems/status/518821243320287232",
].freeze

COLOUR_MAP = {
  red: 31,
  green: 32,
  yellow: 33,
  blue: 34
}.freeze

def say_with_colour(text, colour_name)
  colour_code = COLOUR_MAP.fetch(colour_name)
  puts "\e[#{colour_code}m#{text}\e[0m"
end

class TwitterRenderer
  Context = Struct.new(:registers)
  Site = Struct.new(:config)

  def initialize(options)
    @options = options
    @jekyll_context = Context.new(site: Site.new({}))
  end

  def render
    ERB.new(template)
       .result(binding)
  end

  private

  attr_reader :options, :jekyll_context

  def render_twitter_tag(option)
    say_with_colour "Fetching with option: #{option}", :yellow
    TwitterJekyll::TwitterTag.new(nil, option, nil).render(jekyll_context)
  end

  def template
    <<~HTML
      <html>
        <body>
        <h1>jekyll-twitter-plugin output tests</h1>
        <% options.each do |option| %>
          <h3><%= option %></h3>
          <%= render_twitter_tag(option) %>
          <hr>
        <% end %>
        </body>
      </html>
    HTML
  end
end

def main
  renderer = TwitterRenderer.new(OPTIONS)
  File.open(OUTPUT_FILENAME, "w") do |f|
    f.write renderer.render
  end
end

if __FILE__ == $PROGRAM_NAME
  say_with_colour "Running integration tests...", :red
  main
  say_with_colour "Created file: #{OUTPUT_FILENAME}", :green
end
