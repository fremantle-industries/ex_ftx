defmodule ExFtx.Markets.ShowTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Markets.Show

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "markets/show/get_ok" do
      assert {:ok, market} = ExFtx.Markets.Show.get("BTC/USD")
      assert %ExFtx.Market{} = market
      assert market.base_currency != nil
    end
  end
end
