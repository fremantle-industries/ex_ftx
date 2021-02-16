defmodule ExFtx.FutureStats do
  alias __MODULE__

  @type t :: %FutureStats{}

  defstruct ~w[
    volume
    next_funding_rate
    next_funding_time
    expiration_price
    predicted_expiration_price
    strike_price
    open_interest
  ]a
end
