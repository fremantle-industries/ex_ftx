defmodule ExFtx.OrderBook do
  alias __MODULE__

  @type t :: %OrderBook{
          bids: list,
          asks: list
        }

  defstruct ~w[bids asks]a
end
