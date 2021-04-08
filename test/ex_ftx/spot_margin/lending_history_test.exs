defmodule ExFtx.SpotMargin.LendingHistoryTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.LendingHistory

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 ok" do
    use_cassette "spot_margin/lending_history/get_ok" do
      assert {:ok, lending_history} = ExFtx.SpotMargin.LendingHistory.get()
      assert Enum.count(lending_history) > 0
      assert %ExFtx.LendingHistory{} = Enum.at(lending_history, 0)
    end
  end
end
