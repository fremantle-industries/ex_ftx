defmodule ExFtx.Account do
  alias __MODULE__

  @type t :: %Account{
          backstop_provider: boolean,
          collateral: number,
          free_collateral: number,
          initial_margin_requirement: number,
          leverage: number,
          liquidating: boolean,
          maintenance_margin_requirement: number,
          maker_fee: number,
          margin_fraction: number,
          open_margin_fraction: number,
          taker_fee: number,
          total_account_value: number,
          total_position_size: number,
          username: String.t(),
          positions: list
        }

  defstruct ~w[
    backstop_provider
    collateral
    free_collateral
    initial_margin_requirement
    leverage
    liquidating
    maintenance_margin_requirement
    maker_fee
    margin_fraction
    open_margin_fraction
    taker_fee
    total_account_value
    total_position_size
    username
    positions
  ]a
end
