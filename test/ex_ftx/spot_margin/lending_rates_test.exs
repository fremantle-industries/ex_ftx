defmodule ExFtx.SpotMargin.LendingRatesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.LendingRates

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 ok" do
    use_cassette "spot_margin/lending_rates/get_ok" do
      assert {:ok, lending_rates} = ExFtx.SpotMargin.LendingRates.get()
      assert Enum.count(lending_rates) > 0
      assert %ExFtx.LendingRate{} = Enum.at(lending_rates, 0)
    end
  end
end
