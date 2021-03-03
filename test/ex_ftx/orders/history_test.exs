defmodule ExFtx.Orders.HistoryTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Orders.History

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
  @valid_payload %ExFtx.OrderPayload{
    market: "BTC/USD",
    side: "buy",
    price: 25000.0,
    type: "limit",
    size: 0.0001,
    reduce_only: false,
    ioc: false,
    post_only: true
  }

  test ".get/2 ok" do
    use_cassette "orders/history/get_ok" do
      assert {:ok, _order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert {:ok, orders} = ExFtx.Orders.History.get(@valid_credentials, @valid_payload.market)
      assert Enum.count(orders) > 0
    end
  end

  test ".post/3 unauthorized" do
    use_cassette "orders/history/get_unauthorized" do
      assert {:ok, _order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.History.get(@invalid_credentials, @valid_payload.market) ==
               {:error, "Not logged in"}
    end
  end
end
