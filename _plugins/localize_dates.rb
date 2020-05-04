require 'date'

MONTH_NAMES = %w(januar februar marts april maj juni juli august september oktober november cecember)

module Jekyll
  module LocalizeDates
    def date(time, format)
      if format == "%B %-d, %Y"
        # Hack to correct naming of months and format for the remote-theme
        "#{time.strftime("%-d")}. #{MONTH_NAMES[time.month-1]} #{time.strftime("%Y")}"
      else
        time.strftime(format)
      end
    end
  end
end

Liquid::Template.register_filter(Jekyll::LocalizeDates)
