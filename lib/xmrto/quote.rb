module Xmrto
  class Quote

    def self.get
      response = HTTParty.get("#{base_url}/order_parameter_query/")
      if response["error"]
        raise("Xmrto::Error#{response["error"][-3..-1]}".constantize, response["error_msg"] )
      end
      response
    end

    private

    def self.testnet?
      Xmrto.config.network == :testnet
    end

    def self.livenet?
      Xmrto.config.network == :livenet
    end

    def self.base_url
      if testnet?
        "https://test.xmr.to/api/v2/xmr2btc"
      else
        "https://xmr.to/api/v2/xmr2btc"
      end
    end
  end
end
