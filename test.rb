require 'lib/feednectar'

feed = Feednectar::Feed.new :url => %q{http://feeds.feedburner.com/DiscoDust}

mp3s = feed.find_content_by_type 'mp3'

mp3s.each do |link|
  puts link[:url]
  puts link[:description]
end