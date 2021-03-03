defmodule ExFtx.Orders.CancelByOrderIdTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Orders.CancelByOrderId

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

  test ".delete/2 ok" do
    use_cassette "orders/cancel_by_order_id/delete_ok" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.CancelByOrderId.delete(@valid_credentials, order.id) == :ok
    end
  end

  test ".delete/2 not found" do
    use_cassette "orders/cancel_by_order_id/delete_not_found" do
      assert {:ok, _order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.CancelByOrderId.delete(@valid_credentials, 123) ==
               {:error, "Order not found"}
    end
  end

  test ".delete/2 unauthorized" do
    use_cassette "orders/cancel_by_order_id/delete_unauthorized" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.CancelByOrderId.delete(@invalid_credentials, order.id) ==
               {:error, "Not logged in"}
    end
  end
end
