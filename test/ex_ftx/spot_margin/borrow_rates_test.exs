defmodule ExFtx.SpotMargin.BorrowRatesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.BorrowRates

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
    use_cassette "spot_margin/borrow_rates/get_ok" do
      assert {:ok, borrow_rates} = ExFtx.SpotMargin.BorrowRates.get(@valid_credentials)
      assert Enum.count(borrow_rates) > 0
      assert %ExFtx.BorrowRate{} = Enum.at(borrow_rates, 0)
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "spot_margin/borrow_rates/get_unauthorized" do
      assert ExFtx.SpotMargin.BorrowRates.get(@invalid_credentials) == {:error, "Not logged in"}
    end
  end
end
