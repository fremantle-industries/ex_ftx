defmodule ExFtx.ModifyOrderByClientIdPayload do
  alias __MODULE__

  @type t :: %ModifyOrderByClientIdPayload{
          client_id: ExFtx.OrderPayload.client_id() | nil,
          price: number | nil,
          size: number | nil
        }

  defstruct ~w[
    client_id
    price
    size
  ]a
end
