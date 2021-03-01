defmodule ExFtx.BorrowHistory do
  alias __MODULE__

  @type t :: %BorrowHistory{
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
