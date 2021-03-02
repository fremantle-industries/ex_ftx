defmodule ExFtx.Offer do
  alias __MODULE__

  @type t :: %Offer{
          coin: String.t(),
          rate: number,
          size: number
        }

  defstruct ~w[
    coin
    rate
    size
  ]a
end
