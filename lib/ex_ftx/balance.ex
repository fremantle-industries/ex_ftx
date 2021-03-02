defmodule ExFtx.Balance do
  alias __MODULE__

  @type t :: %Balance{}

  defstruct ~w[
    available_without_borrow
    coin
    free
    spot_borrow
    total
    usd_value
  ]a
end
