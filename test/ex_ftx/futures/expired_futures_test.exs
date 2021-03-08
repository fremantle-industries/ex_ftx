defmodule ExFtx.Futures.ExpiredFuturesTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.ExpiredFutures

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/0" do
    use_cassette "futures/expired_futures/get_ok" do
      assert {:ok, expired_futures} = ExFtx.Futures.ExpiredFutures.get()
      assert Enum.count(expired_futures) != 0
      assert %ExFtx.ExpiredFuture{} = expired_future = Enum.at(expired_futures, 0)
      assert expired_future.post_only != nil
    end
  end
end
