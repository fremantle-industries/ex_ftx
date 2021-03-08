defmodule ExFtx.Markets.TradesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Markets.Trades

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 with default limit, start & end time" do
    use_cassette "markets/trades/get_ok" do
      assert {:ok, trades} = ExFtx.Markets.Trades.get("BTC/USD")
      assert Enum.count(trades) == 20
      assert Enum.at(trades, 0).price > 0
    end
  end

  test ".get/1 error market not found" do
    use_cassette "markets/trades/get_error_market_not_found" do
      assert {:error, :not_found} = ExFtx.Markets.Trades.get("INVALID/MARKET")
    end
  end
end
