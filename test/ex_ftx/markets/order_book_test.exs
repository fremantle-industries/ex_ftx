defmodule ExFtx.Markets.OrderBookTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Markets.OrderBook

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 with default depth" do
    use_cassette "markets/order_book/get_with_default_depth_ok" do
      assert {:ok, order_book} = ExFtx.Markets.OrderBook.get("BTC/USD")
      assert %ExFtx.OrderBook{} = order_book
      assert Enum.count(order_book.bids) == 20
      assert Enum.count(order_book.asks) == 20
    end
  end

  test ".get/1 error market not found" do
    use_cassette "markets/order_book/get_error_market_not_found" do
      assert {:error, :not_found} = ExFtx.Markets.OrderBook.get("INVALID/MARKET")
    end
  end

  test ".get/2 with depth" do
    use_cassette "markets/order_book/get_with_depth_ok" do
      assert {:ok, order_book} = ExFtx.Markets.OrderBook.get("BTC/USD", %{depth: 10})
      assert %ExFtx.OrderBook{} = order_book
      assert Enum.count(order_book.bids) == 10
      assert Enum.count(order_book.asks) == 10
    end
  end
end
