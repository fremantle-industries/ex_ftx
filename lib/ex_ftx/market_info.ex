defmodule ExFtx.MarketInfo do
  alias __MODULE__

  @type t :: %MarketInfo{
          coin: String.t(),
          borrowed: number,
          free: number,
          estimated_rate: number,
          previous_rate: number
        }

  defstruct ~w[
    coin
    borrowed
    free
    estimated_rate
    previous_rate
  ]a
end
