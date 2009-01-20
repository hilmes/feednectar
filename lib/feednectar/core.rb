module Feednectar
  class Feed
    attr_reader :url, :file, :config, :hp
    
    def initialize(config={})
      @config = config
      if config[:file]
        @file = config[:file]
        parse_file
      end
      
      config[:formats] ||= %w[mp3]
    end
    
    def parse_file
      @hp = Hpricot.XML( File.open(@file) )
    end
 
  end
end