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
  body = (today.beginning_of_month..today.end_of_month).map {|d| d.strftime('[%Y/%m/%d]') }.each_slice(7).map{|ds| ds.join(' ') }.join("\n")
  body += "\n\n#{today.strftime('[%Y年]')} #{today.strftime('[%1m月]')}\n\n[月]\n"
  to += "?body=#{URI.encode(body)}"
  { location: to }
end
