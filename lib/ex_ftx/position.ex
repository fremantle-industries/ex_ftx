defmodule ExFtx.Position do
  alias __MODULE__

  @type t :: %Position{
          cost: number,
          entry_price: number,
          estimated_liquidation_price: number,
          future: String.t(),
          initial_margin_requirement: number,
          long_order_size: number,
          maintenance_margin_requirement: number,
          net_size: number,
          open_size: number,
          realized_pnl: number,
          short_order_size: number,
          side: String.t(),
          size: number,
          unrealized_pnl: number,
          collateral_used: number
        }

  defstruct ~w[
    cost
    entry_price
    estimated_liquidation_price
    future
    initial_margin_requirement
    long_order_size
    maintenance_margin_requirement
    net_size
    open_size
    realized_pnl
    short_order_size
    side
    size
    unrealized_pnl
    collateral_used
  ]a
end
