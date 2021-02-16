defmodule ExFtx.Markets.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Markets.List

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1" do
    use_cassette "markets/list/get_ok" do
      assert {:ok, markets} = ExFtx.Markets.List.get()
      assert Enum.count(markets) != 0
      assert %ExFtx.Market{} = market = Enum.at(markets, 0)
      assert market.base_currency != nil
    end
  end
end
