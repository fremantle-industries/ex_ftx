defmodule ExFtx.Coin do
  alias __MODULE__

  @type t :: %Coin{
          bep2_asset: boolean | nil,
          can_convert: boolean,
          can_deposit: boolean,
          can_withdraw: boolean,
          collateral: boolean,
          collateral_weight: number,
          credit_to: term | nil,
          erc20_contract: String.t() | nil,
          fiat: boolean,
          has_tag: boolean,
          id: String.t(),
          is_token: boolean,
          methods: [String.t()],
          name: String.t(),
          spl_mint: String.t(),
          trc20_contract: String.t() | nil,
          usd_fungible: boolean
        }

  defstruct ~w[
    bep2_asset
    can_convert
    can_deposit
    can_withdraw
    collateral
    collateral_weight
    credit_to
    erc20_contract
    fiat
    has_tag
    id
    is_token
    methods
    name
    spl_mint
    trc20_contract
    usd_fungible
  ]a
end
