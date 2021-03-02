defmodule ExFtx.Balance do
  alias __MODULE__

  @type t :: %Balance{
          available_without_borrow: number,
          coin: String.t(),
          free: number,
          spot_borrow: number,
          total: number,
          usd_value: number
        }

  defstruct ~w[
    available_without_borrow
    coin
    free
    spot_borrow
    total
    usd_value
  ]a
end
