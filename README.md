# ExFtx
[![Build Status](https://github.com/fremantle-capital/ex_ftx/workflows/test/badge.svg?branch=main)](https://github.com/fremantle-capital/ex_ftx/actions?query=workflow%3Atest)
[![hex.pm version](https://img.shields.io/hexpm/v/ex_ftx.svg?style=flat)](https://hex.pm/packages/ex_ftx)

FTX API Client for Elixir

## Installation

Add the `ex_ftx` package to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_ftx, "~> 0.0.14"}
  ]
end
```

## Requirements

- Erlang 22+
- Elixir 1.10+

## API Documentation

https://docs.ftx.com/#overview

## REST API

#### Markets

- [x] `GET /markets`
- [x] `GET /markets/{market_name}`
- [x] `GET /markets/{market_name}/orderbook?depth={depth}`
- [x] `GET /markets/{market_name}/trades?limit={limit}&start_time={start_time}&end_time={end_time}`
- [x] `GET /markets/{market_name}/candles?resolution={resolution}&limit={limit}&start_time={start_time}&end_time={end_time}`

#### Futures

- [x] `GET /futures`
- [x] `GET /futures/{future_name}`
- [x] `GET /futures/{future_name}/stats`
- [x] `GET /funding_rates`
- [ ] `GET /indexes/{index_name}/weights`
- [x] `GET /expired_futures`
- [ ] `GET /indexes/{market_name}/candles?resolution={resolution}&limit={limit}&start_time={start_time}&end_time={end_time}`

#### Account

- [x] `GET /account`
- [x] `GET /positions`
- [ ] `POST /account/leverage`

#### Subaccounts

- [ ] `GET /subaccounts`
- [ ] `POST /subaccounts`
- [ ] `POST /subaccounts/update_name`
- [ ] `DELETE /subaccounts`
- [ ] `GET /subaccounts/{nickname}/balances`
- [ ] `POST /subaccounts/transfer`

#### Wallet

- [x] `GET /wallet/coins`
- [x] `GET /wallet/balances`
- [ ] `GET /wallet/all_balances`
- [ ] `GET /wallet/deposit_address/{coin}?method={method}`
- [ ] `GET /wallet/deposits`
- [ ] `GET /wallet/withdrawals`
- [ ] `POST /wallet/withdrawals`
- [x] `GET /wallet/airdrops`
- [ ] `GET /wallet/saved_addresses`
- [ ] `POST /wallet/saved_addresses`
- [ ] `DELETE /wallet/saved_addresses/{saved_address_id}`

#### Orders

- [x] `GET /orders`
- [ ] `GET /orders?market={market}`
- [ ] `GET /orders/history?market={market}`
- [ ] `GET /conditional_orders?market={market}`
- [ ] `GET /conditional_orders/{conditional_order_id}/triggers`
- [ ] `GET /conditional_orders/history?market={market}`
- [x] `POST /orders`
- [ ] `POST /conditional_orders`
- [x] `POST /orders/{order_id}/modify`
- [x] `POST /orders/by_client_id/{client_order_id}/modify`
- [ ] `POST /conditional_orders/{order_id}/modify`
- [ ] `GET /orders/{order_id}`
- [ ] `GET /orders/by_client_id/{client_order_id}`
- [x] `DELETE /orders/{order_id}`
- [x] `DELETE /orders/by_client_id/{client_order_id}`
- [ ] `DELETE /conditional_orders/{id}`
- [x] `DELETE /orders`

#### Convert

- [ ] `POST /otc/quotes`
- [ ] `GET /otc/quotes/{quoteId}`
- [ ] `POST /otc/quotes/{quote_id}/accept`

#### Spot Margin

- [x] `GET /spot_margin/history`
- [x] `GET /spot_margin/borrow_rates`
- [x] `GET /spot_margin/lending_rates`
- [x] `GET /spot_margin/borrow_summary`
- [x] `GET /spot_margin/market_info?market={market}`
- [x] `GET /spot_margin/borrow_history`
- [x] `GET /spot_margin/lending_history`
- [x] `GET /spot_margin/offers`
- [x] `GET /spot_margin/lending_info`
- [x] `POST /spot_margin/offers`

#### Fills

- [x] `GET /fills?market={market}`

#### Funding Payments

- [x] `GET /funding_payments`

#### Leveraged Tokens

- [ ] `GET /lt/tokens`
- [ ] `GET /lt/{token_name}`
- [ ] `GET /lt/balances`
- [ ] `GET /lt/creations`
- [ ] `POST /lt/{token_name}/create`
- [ ] `GET /lt/redemptions`
- [ ] `POST /lt/{token_name}/redeem`

#### Options

- [ ] `GET /options/requests`
- [ ] `GET /options/my_requests`
- [ ] `POST /options/requests`
- [ ] `DELETE /options/requests/{request_id}`
- [ ] `GET /options/requests/{request_id}/quotes`
- [ ] `POST  /options/requests/{request_id}/quotes`
- [ ] `GET /options/my_quotes`
- [ ] `DELETE /options/quotes/<quote_id>`
- [ ] `POST /options/quotes/<quote_id>/accept`
- [ ] `GET /options/account_info`
- [ ] `GET /options/positions`
- [ ] `GET /options/trades`
- [ ] `GET /options/fills`
- [ ] `GET /stats/24h_options_volume`
- [ ] `GET /options/historical_volumes/BTC`
- [ ] `GET /options/open_interest/BTC`
- [ ] `GET options/historical_open_interest/BTC`

#### SRM Staking

- [ ] `GET /staking/stakes`
- [ ] `GET /staking/unstake_requests`
- [ ] `GET /staking/balances`
- [ ] `POST /staking/unstake_requests`
- [ ] `DELETE /staking/unstake_requests/{request_id}`
- [ ] `GET /staking/staking_rewards`
- [ ] `POST /srm_stakes/stakes`

## Authors

- Alex Kwiatkowski - alex+git@fremantle.io

## License

`ex_ftx` is released under the [MIT license](./LICENSE)
