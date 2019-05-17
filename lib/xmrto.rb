require 'xmrto/config'
require 'xmrto/transfer'
require 'xmrto/version'
require 'httparty'

module Xmrto
  def self.config
    @@config ||= Xmrto::Config.instance
    @@config.network ||= :testnet
    @@config
  end
end
