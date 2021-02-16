defmodule ExFtx.Futures.ShowTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.Show

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "futures/show/get_ok" do
      assert {:ok, future} = ExFtx.Futures.Show.get("BTC-PERP")
      assert %ExFtx.Future{} = future
      assert future.post_only != nil
    end
  end
end
