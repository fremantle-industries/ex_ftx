defmodule ExFtx.FundingRates do
  alias __MODULE__

  @type t :: %FundingRates{
          future: String.t(),
          rate: number,
          time: String.t()
        }

  defstruct ~w[
    future
    rate
    time
  ]a
end
