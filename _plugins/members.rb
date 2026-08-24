require "csv"
require "yaml"
require "net/http"
require "uri"
require "open-uri"

Jekyll::Hooks.register :site, :after_init do |site|
  Jekyll.logger.info "Members:", "Fetching sheet"
  url = site.config["membersdata"]
  text = URI.open(url).read

  # File.write("debug.tsv", text)
  rows = CSV.parse(
    text,
    headers: true,
    col_sep: "\t"
  )

  members = rows.map(&:to_h)

  File.write(
    File.join(site.source, "_data", "members.yml"),
    members.to_yaml
  )

  site.data["members"] = members
end
