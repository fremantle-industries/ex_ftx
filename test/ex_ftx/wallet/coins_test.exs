defmodule ExFtx.Wallet.CoinsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Wallet.Coins

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 ok" do
    use_cassette "wallet/coins/get_ok" do
      assert {:ok, coins} = ExFtx.Wallet.Coins.get()
      assert Enum.count(coins) > 0
      assert %ExFtx.Coin{} = offer = Enum.at(coins, 0)
      assert offer.can_convert != nil
    end
  end
end
