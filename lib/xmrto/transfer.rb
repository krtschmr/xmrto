module Xmrto

  (1..14).map do |i|
    clazz = "class Error#{i.to_s.rjust(3, "0")} < StandardError; end"
    eval(clazz)
  end

 class Transfer


   attr_accessor :uuid, :xmr_price_btc, :state, :btc_amount, :btc_dest_address, :xmr_required_amount, :xmr_receiving_address,
   :xmr_receiving_integrated_address, :xmr_required_payment_id_long, :xmr_required_payment_id_short, :created_at, :expires_at, :seconds_till_timeout, :xmr_amount_total, :xmr_amount_remaining, :xmr_num_confirmations_remaining, :xmr_recommended_mixin, :btc_num_confirmations_before_purge, :btc_num_confirmations, :btc_transaction_id


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
      fetch_status.map {|attr, value| send("#{attr}=", value) }
      state
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
