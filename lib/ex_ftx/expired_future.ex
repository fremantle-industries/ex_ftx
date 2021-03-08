defmodule ExFtx.ExpiredFuture do
  alias __MODULE__

  @type t :: %ExpiredFuture{
          ask: number,
          bid: number,
          description: String.t(),
          enabled: boolean,
          expired: boolean,
          expiry: String.t(),
          expiry_description: String.t(),
          group: String.t(),
          imf_factor: number,
          index: number,
          last: number,
          lower_bound: number,
          margin_price: number,
          mark: number,
          move_start: term,
          name: String.t(),
          perpetual: boolean,
          position_limit_weight: number,
          post_only: boolean,
          price_increment: number,
          size_increment: number,
          type: String.t(),
          underlying: String.t(),
          upper_bound: number
        }

  defstruct ~w[
    ask
    bid
    description
    enabled
    expired
    expiry
    expiry_description
    group
    imf_factor
    index
    last
    lower_bound
    margin_price
    mark
    move_start
    name
    perpetual
    position_limit_weight
    post_only
    price_increment
    size_increment
    type
    underlying
    upper_bound
  ]a
end
