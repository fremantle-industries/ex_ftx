defmodule ExFtx.Futures.FundingRatesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.FundingRates

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/0 all futures with default time period" do
    use_cassette "futures/funding_rates/get_ok" do
      assert {:ok, funding_rates} = ExFtx.Futures.FundingRates.get()
      assert Enum.count(funding_rates) == 500
      assert %ExFtx.FundingRate{} = funding_rate = Enum.at(funding_rates, 0)
      assert funding_rate.future != nil
    end
  end

  test ".get/1 single future with default time period" do
    use_cassette "futures/funding_rates/get_single_future_ok" do
      assert {:ok, funding_rates} = ExFtx.Futures.FundingRates.get(%{future: "BTC-PERP"})
      assert Enum.count(funding_rates) == 500
      assert %ExFtx.FundingRate{} = funding_rate = Enum.at(funding_rates, 0)
      assert funding_rate.future != nil
    end
  end

  test ".get/1 error future not found" do
    use_cassette "futures/funding_rates/get_error_future_not_found" do
      assert ExFtx.Futures.FundingRates.get(%{future: "INVALID-FUTURE"}) == {:error, :not_found}
    end
  end
end
