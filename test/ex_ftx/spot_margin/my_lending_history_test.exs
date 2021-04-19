defmodule ExFtx.SpotMargin.MyLendingHistoryTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.MyLendingHistory

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

  test ".get/1 ok returns the latest rates for all coins" do
    use_cassette "spot_margin/my_lending_history/get_ok" do
      assert {:ok, my_lending_history} = ExFtx.SpotMargin.MyLendingHistory.get(@valid_credentials)
      assert Enum.count(my_lending_history) > 0
      assert %ExFtx.MyLendingHistory{} = Enum.at(my_lending_history, 0)
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "spot_margin/my_lending_history/get_unauthorized" do
      assert ExFtx.SpotMargin.MyLendingHistory.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
