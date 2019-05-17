require 'singleton'
module Xmrto
  class Config
    include Singleton
    attr_accessor :network, :debug
  end
end
