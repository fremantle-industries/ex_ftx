defmodule ExFtx.FundingRate do
  alias __MODULE__

  @type t :: %FundingRate{
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
