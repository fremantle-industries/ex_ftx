defmodule ExFtx.AirDrop do
  alias __MODULE__

  @type t :: %AirDrop{
          coin: String.t(),
          id: pos_integer,
          size: number,
          time: String.t(),
          status: String.t()
        }

  defstruct ~w[
    coin
    id
    size
    time
    status
  ]a
end
