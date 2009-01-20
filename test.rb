require 'lib/feedlicker'

feed = Feedlicker::Feed.new :file => "test/xml/SchitzPopinov.xml"

feed.hp.entries.each do |entry|
  html = Hpricot.parse(entry.content)
  (html/:a).each do |link|
    puts link
  end
end