defmodule ExFtx.LendingInfo do
  alias __MODULE__

  @type t :: %LendingInfo{
          coin: String.t(),
          lendable: number,
          locked: number,
          min_rate: number,
          offered: number
        }

  defstruct ~w[
    coin
    lendable
    locked
    min_rate
    offered
  ]a
end
