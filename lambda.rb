require 'date'
require 'time'
require 'active_support/core_ext/date'
require 'active_support/core_ext/time'
require 'json'

def handler(event:, context:)
  project = context['PROJECT_NAME'] || ENV['PROJECT']
  theday = context['RUN_AT_PAST'] || Date.today
  to = project + '/'
  to +=  "#{theday.strftime('%Y%%2F%m')}"
  body = "table:days\n [日曜日]\t[月曜日]\t[火曜日]\t[水曜日]\t[木曜日]\t[金曜日]\t[土曜日]\n"
  body += theday.all_month.slice_before(&:sunday?).map.with_index { |ds, i|
    ?\t + ds.map { |d|
        d.strftime('[%Y/%m/%d]')
      }.tap { |l|
        (7 - l.size).times { l.unshift '' } if i == 0
        ds
      }.join(?\t)
  }.join ?\n
  body += "\n\n#{theday.strftime('[%Y年]')} #{theday.strftime('[%1m月]')}\n"
  body += "##{theday.prev_month.strftime('%Y/%2m')} ##{theday.next_month.strftime('%Y/%2m')}\n\n[月]"
  to += "?body=#{CGI.escape(body)}"
  { location: to }
end
