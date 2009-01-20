require 'lib/feednectar'

feed = Feednectar::Feed.new :file => "test/xml/resonator.xml"

mp3s = feed.find_content_by_type 'mp3'

mp3s.each do |link|
  puts link[:url]
  puts link[:description]
end