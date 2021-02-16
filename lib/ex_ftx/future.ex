defmodule ExFtx.Future do
  alias __MODULE__

  @type t :: %Future{
          ask: number,
          bid: number,
          change_1h: number,
          change_24h: number,
          change_bod: number,
          volume_usd_24h: number,
          volume: number,
          description: String.t(),
          enabled: boolean,
          expired: boolean,
          expiry: String,
          index: number,
          imf_factor: number,
          last: number,
          lower_bound: number,
          mark: number,
          name: String.t(),
          perpetual: boolean,
          position_limit_weight: number,
          post_only: boolean,
          price_increment: number,
          size_increment: number,
          underlying: String.t(),
          upper_bound: number,
          type: String.t()
        }

  defstruct ~w[
    ask
    bid
    change_1h
    change_24h
    change_bod
    volume_usd_24h
    volume
    description
    enabled
    expired
    expiry
    index
    imf_factor
    last
    lower_bound
    mark
    name
    perpetual
    position_limit_weight
    post_only
    price_increment
    size_increment
    underlying
    upper_bound
    type
  ]a
end
