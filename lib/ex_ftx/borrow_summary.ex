defmodule ExFtx.BorrowSummary do
  alias __MODULE__

  @type t :: %BorrowSummary{
          coin: String.t(),
          size: number
        }

  defstruct ~w[
    coin
    size
  ]a
end
