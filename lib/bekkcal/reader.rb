require 'net/http'
require 'uri'

module Bekkcal
  class Reader
    def self.personal(host, username, password)
      b = Bekkcal::Notes.new(host, username, password)
      b.personal if b.login      
    end
      
    def self.bekk(host, username, password)
      b = Bekkcal::Notes.new(host, username, password)
      b.bekk if b.login
    end    
  end
end
