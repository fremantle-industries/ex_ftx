defmodule ExFtx.SpotMargin.LendingInfoTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.LendingInfo

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
    use_cassette "spot_margin/lending_info/get_ok" do
      assert {:ok, lending_info} = ExFtx.SpotMargin.LendingInfo.get(@valid_credentials)
      assert Enum.count(lending_info) > 0
      assert %ExFtx.LendingInfo{} = lending_info = Enum.at(lending_info, 0)
      assert lending_info.offered != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "spot_margin/lending_info/get_unauthorized" do
      assert ExFtx.SpotMargin.LendingInfo.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
