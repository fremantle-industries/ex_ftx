defmodule ExFtx.Fill do
  alias __MODULE__

  @type t :: %Fill{
          fee: number,
          fee_currency: String.t(),
          fee_rate: number,
          future: String.t(),
          id: pos_integer,
          liquidity: String.t(),
          market: String.t(),
          base_currency: String.t() | nil,
          quote_currency: String.t() | nil,
          order_id: pos_integer,
          trade_id: pos_integer,
          price: number,
          side: String.t(),
          size: number,
          time: String.t(),
          type: String.t()
        }

  defstruct ~w[
    fee
    fee_currency
    fee_rate
    future
    id
    liquidity
    market
    base_currency
    quote_currency
    order_id
    trade_id
    price
    side
    size
    time
    type
  ]a
end
