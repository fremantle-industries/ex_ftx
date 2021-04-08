defmodule ExFtx.MyLendingHistory do
  alias __MODULE__

  @type t :: %MyLendingHistory{
          coin: String.t(),
          cost: number,
          rate: number,
          size: number,
          time: String.t()
        }

  defstruct ~w[
    coin
    cost
    rate
    size
    time
  ]a
end
