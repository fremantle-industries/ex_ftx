defmodule ExFtx.Market do
  alias __MODULE__

  @type t :: %Market{
          name: String.t(),
          base_currency: String.t() | nil,
          quote_currency: String.t() | nil,
          type: String.t(),
          underlying: String.t(),
          enabled: boolean,
          ask: number | nil,
          bid: number | nil,
          last: number | nil,
          post_only: boolean,
          price_increment: number,
          size_increment: number,
          restricted: boolean
        }

  defstruct ~w[
    name
    base_currency
    quote_currency
    type
    underlying
    enabled
    ask
    bid
    last
    post_only
    price_increment
    size_increment
    restricted
  ]a
end
