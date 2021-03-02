defmodule ExFtx.Wallet.AllBalancesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Wallet.AllBalances

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
    use_cassette "wallet/all_balances/get_ok" do
      assert {:ok, all_balances} = ExFtx.Wallet.AllBalances.get(@valid_credentials)
      assert Enum.count(all_balances) > 0
      assert %{"Testing Account" => account_balances} = all_balances
      assert Enum.count(account_balances) > 0
      assert %ExFtx.Balance{} = account_balance = Enum.at(account_balances, 0)
      assert account_balance.available_without_borrow != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "wallet/all_balances/get_unauthorized" do
      assert ExFtx.Wallet.AllBalances.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
