defmodule ExFtx.LendingRate do
  alias __MODULE__

  @type t :: %LendingRate{
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
