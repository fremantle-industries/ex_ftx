defmodule ExFtx.Futures.FundingRatesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.FundingRates

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "futures/funding_rates/get_ok" do
      assert {:ok, funding_rates} = ExFtx.Futures.FundingRates.get()
      assert Enum.count(funding_rates) > 0
      assert %ExFtx.FundingRate{} = funding_rate = Enum.at(funding_rates, 0)
      assert funding_rate.future != nil
    end
  end
end
