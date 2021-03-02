defmodule ExFtx.Wallet.AirDropsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Wallet.AirDrops

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
    use_cassette "wallet/air_drops/get_ok" do
      assert {:ok, _air_drops} = ExFtx.Wallet.AirDrops.get(@valid_credentials)
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "wallet/air_drops/get_unauthorized" do
      assert ExFtx.Wallet.AirDrops.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
