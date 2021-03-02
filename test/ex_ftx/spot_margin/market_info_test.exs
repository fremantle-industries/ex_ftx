defmodule ExFtx.SpotMargin.MarketInfoTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.MarketInfo

  setup_all do
    HTTPoison.start()
    :ok
  end

  @valid_credentials %ExFtx.Credentials{
    api_key: System.get_env("FTX_API_KEY"),
    api_secret: System.get_env("FTX_API_SECRET")
  }
  @invalid_credentials %ExFtx.Credentials{
    api_key: "invalid",
    api_secret: "invalid"
  }

  test ".get/1 ok" do
    use_cassette "spot_margin/market_info/get_ok" do
      assert {:ok, market_info} = ExFtx.SpotMargin.MarketInfo.get(@valid_credentials, "BTC/USD")
      assert Enum.count(market_info) > 0
      assert %ExFtx.MarketInfo{} = market_info = Enum.at(market_info, 0)
      assert market_info.estimated_rate > 0
    end
  end

  test ".get/1 invalid market" do
    use_cassette "spot_margin/market_info/get_invalid_market" do
      assert ExFtx.SpotMargin.MarketInfo.get(@valid_credentials, "INVALID/MARKET") ==
               {:error, "No such market: INVALID/MARKET "}
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "spot_margin/market_info/get_unauthorized" do
      assert ExFtx.SpotMargin.MarketInfo.get(@invalid_credentials, "BTC/USD") ==
               {:error, "Not logged in"}
    end
  end
end
