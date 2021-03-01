defmodule ExFtx.BorrowRate do
  alias __MODULE__

  @type t :: %BorrowRate{
          coin: String.t(),
          estimate: number,
          previous: number
        }

  defstruct ~w[
    coin
    estimate
    previous
  ]a
end
