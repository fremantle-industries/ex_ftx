defmodule ExFtx.SpotMargin.OffersTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.Offers

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
    use_cassette "spot_margin/offers/get_ok" do
      assert {:ok, offers} = ExFtx.SpotMargin.Offers.get(@valid_credentials)
      assert Enum.count(offers) > 0
      assert %ExFtx.Offer{} = offer = Enum.at(offers, 0)
      assert offer.rate != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "spot_margin/offers/get_unauthorized" do
      assert ExFtx.SpotMargin.Offers.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
