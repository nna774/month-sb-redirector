require 'date'
require 'time'
require 'active_support/core_ext/date'
require 'active_support/core_ext/time'
require 'json'
require 'uri'

def handler(event:, context:)
  project = ENV['PROJECT']
  today = Date.today
  to = project + '/'
  to +=  "#{today.strftime('%Y%%2F%m')}"
  body = "table:days\n [日曜日]\t[月曜日]\t[火曜日]\t[水曜日]\t[木曜日]\t[金曜日]\t[土曜日]\n"
  body += today.all_month.slice_before(&:sunday?).map.with_index { |ds, i|
    ?\t + ds.map { |d|
        d.strftime('[%Y/%m/%d]')
      }.tap { |l|
        (7 - l.size).times { l.unshift '' } if i == 0
        ds
      }.join(?\t)
  }.join ?\n
  body += "\n\n#{today.strftime('[%Y年]')} #{today.strftime('[%1m月]')}\n\n[月]"
  to += "?body=#{URI.encode(body)}"
  { location: to }
end
