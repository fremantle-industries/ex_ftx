defmodule ExFtx.Candle do
  alias __MODULE__

  @type t :: %Candle{
          start_time: String.t(),
          open: number,
          high: number,
          low: number,
          close: number,
          volume: number
        }

  defstruct ~w[start_time open high low close volume]a
end
