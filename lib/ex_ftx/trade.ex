defmodule ExFtx.Trade do
  alias __MODULE__

  @type t :: %Trade{
          id: number,
          liquidation: boolean,
          price: number,
          side: String.t(),
          size: number,
          time: String.t()
        }

  defstruct ~w[id liquidation price side size time]a
end
