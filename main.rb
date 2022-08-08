# for run this code by hand

require_relative './lambda'

if ARGV.size == 0
  puts "usage: main.rb '2022/07/01'"
  exit 1
end

puts handler(
  event: nil,
  context: {
    'PROJECT_NAME' => 'https://scrapbox.io/rebuild-kitashirakawa',
    'RUN_AT_PAST' => Date.parse(ARGV[0]),
  }
)[:location]
