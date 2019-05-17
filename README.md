
# xmr.to API Wrapper

***ALWAYS DEVELOP IN THE TESTNET!***

default the gem wil run in `:testnet` mode. http://test.xmr.to. However, this version of xmr.to is running on the stagenet

    Xmrto.config.network = :testnet #livenet

To create a transfer, simply call

    transfer = Xmrto::Transfer.create("mqm6GJzsmzvwqPbH5p7tKrRRdHrMkmRXjS", 0.01333)
    => #<Xmrto::Transfer:0x000055a7dbc46908 @state="TO_BE_CREATED", @uuid="xmrto-KLYXfW">

    transfer.update
    => "UNPAID"

To work with an existing transfer

    transfer = Xmrto::Transfer.new("xmrto-AWYXfW")
    => #<Xmrto::Transfer:0x000055a7dbec3000 @uuid="xmrto-AWYXfW">
    transfer.update
	=> "BTC_SENT"



Errors will be thrown accordingly

    transfer = Xmrto::Transfer.create("mqm6GJzsmzvwqPbH5p7tKrRRdHrMkmRXjS", 20000)
    Xmrto::Error004: bitcoin amount out of bounds




Every Transfer object hast the same attributes as the API returns

    :uuid
    :xmr_price_btc
    :state
    :btc_amount
    :btc_dest_address
    :xmr_required_amount
    :xmr_receiving_address
    :xmr_receiving_integrated_address
    :xmr_required_payment_id_long
    :xmr_required_payment_id_short
    :created_at
    :expires_at
    :seconds_till_timeout
    :xmr_amount_total
    :xmr_amount_remaining
    :xmr_num_confirmations_remaining
    :xmr_recommended_mixin
    :btc_num_confirmations_before_purge
    :btc_num_confirmations
    :btc_transaction_id


if you need help, ask in #monero @ freenode.net
