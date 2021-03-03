defmodule ExFtx.Order do
  alias __MODULE__

  @type t :: %Order{
          created_at: String.t(),
          filled_size: number,
          future: String.t(),
          id: pos_integer,
          market: ExFtx.Market.name(),
          price: number,
          remaining_size: number,
          side: String.t(),
          size: number,
          status: String.t(),
          type: String.t(),
          reduce_only: boolean,
          ioc: boolean,
          post_only: boolean,
          client_id: ExFtx.OrderPayload.client_id()
        }

  defstruct ~w[
    created_at
    filled_size
    future
    id
    market
    price
    remaining_size
    side
    size
    status
    type
    reduce_only
    ioc
    post_only
    client_id
  ]a
end
