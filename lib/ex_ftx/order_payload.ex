defmodule ExFtx.OrderPayload do
  alias __MODULE__

  @type client_id :: String.t() | nil
  @type t :: %OrderPayload{
          market: ExFtx.Market.name(),
          side: String.t(),
          price: number,
          type: String.t(),
          size: number,
          reduce_only: boolean,
          ioc: boolean,
          post_only: boolean,
          client_id: client_id()
        }

  defstruct ~w[
    market
    side
    price
    type
    size
    reduce_only
    ioc
    post_only
    client_id
  ]a
end
