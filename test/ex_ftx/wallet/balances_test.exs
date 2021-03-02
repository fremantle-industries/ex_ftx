defmodule ExFtx.Wallet.BalancesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Wallet.Balances

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
    use_cassette "wallet/balances/get_ok" do
      assert {:ok, balances} = ExFtx.Wallet.Balances.get(@valid_credentials)
      assert Enum.count(balances) > 0
      assert %ExFtx.Balance{} = balance = Enum.at(balances, 0)
      assert balance.available_without_borrow != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "wallet/balances/get_unauthorized" do
      assert ExFtx.Wallet.Balances.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
