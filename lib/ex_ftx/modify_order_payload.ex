defmodule ExFtx.ModifyOrderPayload do
  alias __MODULE__

  @type t :: %ModifyOrderPayload{
          price: number | nil,
          size: number | nil
        }

  defstruct ~w[
    price
    size
  ]a
end
