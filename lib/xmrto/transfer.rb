module Xmrto

  (1..14).map do |i|
    clazz = "class Error#{i.to_s.rjust(3, "0")} < StandardError; end"
    eval(clazz)
  end

 class Transfer

   attr_accessor :uuid, :state

   def initialize(uuid = nil)
     self.uuid = uuid
   end

    def self.create(btc_address, btc_amount)
      new.create(btc_address, btc_amount)
    end

    def self.status(uuid)
      new(uuid).update
    end

    def create(btc_address, btc_amount)
      request = post_request("/order_create/", { "btc_dest_address": btc_address,  "btc_amount": btc_amount })
      self.uuid = request["uuid"]
      self.state = request["state"]
      self
    end

    def update
      fetch_status.map{|attr, value| instance_variable_set("@#{attr}", value) }
      state
    end

    def method_missing(m, *args, &block)
      if instance_values.has_key?(m.to_s)
        instance_values[m.to_s]
      else
        super
      end
    end

    def testnet?
      Xmrto.config.network == :testnet
    end

    def livenet?
      Xmrto.config.network == :livenet
    end

    def post_request(endpoint, args)
      url = "#{base_url}#{endpoint}"
      p "sending POST request to: #{url} with params: #{args.to_json}" if Xmrto.config.debug
      response = HTTParty.post(url, body: args.to_json, headers: { 'Content-Type' => 'application/json' } )
      if response["error"]
        raise("Xmrto::Error#{response["error"][-3..-1]}".constantize, response["error_msg"] )
      end
      response
    end

    private

    def base_url
      if testnet?
        "https://test.xmr.to/api/v2/xmr2btc"
      else
        "https://xmr.to/api/v2/xmr2btc"
      end
    end

    def fetch_status
      post_request("/order_status_query/", {uuid: uuid})
    end
  end

end
