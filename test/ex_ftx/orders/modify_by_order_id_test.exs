defmodule ExFtx.Orders.ModifyByOrderIdTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Orders.ModifyByOrderId

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
  @valid_modify_payload %ExFtx.ModifyOrderPayload{
    price: 25001.0,
    size: 0.00011
  }
  @insufficient_margin_modify_payload Map.put(@valid_modify_payload, :size, 1.0)
  @size_too_small_modify_payload Map.put(@valid_modify_payload, :size, 0.00001)

  test ".post/2 ok" do
    use_cassette "orders/modify_by_order_id/post_ok" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert {:ok, modified_order} =
               ExFtx.Orders.ModifyByOrderId.post(
                 @valid_credentials,
                 order.id,
                 @valid_modify_payload
               )

      assert modified_order.id != order.id
      assert modified_order.created_at != nil
    end
  end

  test ".post/2 insufficient margin" do
    use_cassette "orders/modify_by_order_id/post_insufficient_margin" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.ModifyByOrderId.post(
               @valid_credentials,
               order.id,
               @insufficient_margin_modify_payload
             ) ==
               {:error, "Not enough balances"}
    end
  end

  test ".post/2 size too small" do
    use_cassette "orders/modify_by_order_id/post_size_too_small" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.ModifyByOrderId.post(
               @valid_credentials,
               order.id,
               @size_too_small_modify_payload
             ) ==
               {:error, "Size too small for provide"}
    end
  end

  test ".post/2 unauthorized" do
    use_cassette "orders/modify_by_order_id/post_unauthorized" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.ModifyByOrderId.post(
               @invalid_credentials,
               order.id,
               @valid_modify_payload
             ) ==
               {:error, "Not logged in"}
    end
  end
end
