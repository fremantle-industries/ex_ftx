defmodule ExFtx.Futures.StatsTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.Stats

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "futures/stats/get_ok" do
      assert {:ok, stats} = ExFtx.Futures.Stats.get("BTC-PERP")
      assert %ExFtx.FutureStats{} = stats
      assert stats.open_interest != nil
    end
  end
end
