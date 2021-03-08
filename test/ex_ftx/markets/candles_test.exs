defmodule ExFtx.Markets.CandlesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Markets.Candles

  setup_all do
    HTTPoison.start()
    :ok
  end

  @resolution 60

  test ".get/1 with default limit, start & end time" do
    use_cassette "markets/candles/get_ok" do
      assert {:ok, candles} = ExFtx.Markets.Candles.get("BTC/USD", @resolution)
      assert Enum.count(candles) == 1500
      assert Enum.at(candles, 0).start_time != nil
    end
  end

  test ".get/1 error market not found" do
    use_cassette "markets/candles/get_error_market_not_found" do
      assert {:error, :not_found} = ExFtx.Markets.Candles.get("INVALID/MARKET", @resolution)
    end
  end

  test ".get/2 with limit" do
    use_cassette "markets/candles/get_with_limit_ok" do
      assert {:ok, candles} = ExFtx.Markets.Candles.get("BTC/USD", @resolution, %{limit: 50})
      assert Enum.count(candles) == 50
      assert Enum.at(candles, 0).start_time != nil
    end
  end
end
