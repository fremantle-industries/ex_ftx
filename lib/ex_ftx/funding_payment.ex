defmodule ExFtx.FundingPayment do
  alias __MODULE__

  @type t :: %FundingPayment{
          future: String.t(),
          id: pos_integer,
          payment: number,
          time: String.t(),
          rate: number
        }

  defstruct ~w[
    future
    id
    payment
    time
    rate
  ]a
end
