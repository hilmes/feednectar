module Feednectar
  class Feed
    attr_reader :url, :file, :config, :hp, :output
    
    def initialize(config={})
      @config = config
      if config[:file]
        @file = config[:file]
        parse_file
      end

      if config[:url]
        @url = config[:url]
        parse_url
      end

      @config[:types] ||= %w{mp3}
      @output = {}
    end
    
    def parse_file
      @hp = Hpricot.XML( File.open(@file) )
    end
    
    def parse_url
      @hp = Hpricot.XML( open(@url) )
    end
 
    def find_content
      config[:types].each do |type|
        find_content_by_type type
      end
      output
    end
    
    def find_content_by_type(type)
      hp.entries.each do |entry|
        coder = HTMLEntities.new
        html = Hpricot.parse entry.content
        (html/:a).each do |link|
          if link['href'].match(/\.#{type}/i)
            output[type] ||= []
            output[type] << { :url => link['href'], :description => coder.decode(link.innerHTML) }
          end
        end
      end
      output[type]
    end
    
  end
end