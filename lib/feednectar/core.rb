module Feednectar
  class Feed
    attr_reader :url, :file, :config, :hp, :output
    
    def initialize(config={})
      @config = config
      if config[:file]
        @file = config[:file]
        parse_file
      end
      
      @config[:types] ||= %w{mp3}
      @output = {}
    end
    
    def parse_file
      @hp = Hpricot.XML( File.open(@file) )
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
          if link['href'].match(/#{type}/)
            output[type] ||= []
            output[type] << { :url => link['href'], :description => coder.decode(link.innerHTML) }
          end
        end
      end
      output[type]
    end
    
  end
end