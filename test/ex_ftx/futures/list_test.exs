defmodule ExFtx.Futures.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Futures.List

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "futures/list/get_ok" do
      assert {:ok, futures} = ExFtx.Futures.List.get()
      assert Enum.count(futures) != 0
      assert %ExFtx.Future{} = future = Enum.at(futures, 0)
      assert future.post_only != nil
    end
  end
end
