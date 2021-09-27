defmodule ExFtx.LendingPayload do
  alias __MODULE__

  @type client_id :: String.t() | nil
  @type t :: %LendingPayload{
          coin: String.t(),
          size: number,
          rate: number,
        }

  defstruct ~w[
    coin
    size
    rate
  ]a
end
