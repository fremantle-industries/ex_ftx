defmodule ExFtx.SpotMargin.LendingHistoryTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.LendingHistory

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/0 ok returns the lending history for all coins" do
    use_cassette "spot_margin/lending_history/get_ok" do
      assert {:ok, lending_history} = ExFtx.SpotMargin.LendingHistory.get()
      assert length(lending_history) > 0
      assert %ExFtx.LendingHistory{} = Enum.at(lending_history, 0)

      coins = lending_history |> Enum.map(& &1.coin) |> Enum.uniq()
      assert length(coins) > 1
    end
  end

  test ".get/1 ok returns the lending history for the given coin" do
    use_cassette "spot_margin/lending_history/get_ok_with_coin" do
      assert {:ok, lending_history} = ExFtx.SpotMargin.LendingHistory.get(%{coin: "BTC"})
      assert length(lending_history) > 0
      assert %ExFtx.LendingHistory{} = Enum.at(lending_history, 0)

      coins = lending_history |> Enum.map(& &1.coin) |> Enum.uniq()
      assert length(coins) == 1
    end
  end
end
