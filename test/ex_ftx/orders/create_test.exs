defmodule ExFtx.Orders.CreateTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Orders.Create

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
  @insufficient_margin_payload Map.put(@valid_payload, :size, 1.0)
  @size_too_small_payload Map.put(@valid_payload, :size, 0.00001)

  test ".post/2 ok" do
    use_cassette "orders/create/post_ok" do
      assert {:ok, order} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)
      assert order.created_at != nil
    end
  end

  test ".post/2 insufficient margin" do
    use_cassette "orders/create/post_insufficient_margin" do
      assert ExFtx.Orders.Create.post(@valid_credentials, @insufficient_margin_payload) ==
               {:error, "Not enough balances"}
    end
  end

  test ".post/2 size too small" do
    use_cassette "orders/create/post_size_too_small" do
      assert ExFtx.Orders.Create.post(@valid_credentials, @size_too_small_payload) ==
               {:error, "Size too small"}
    end
  end

  test ".post/2 unauthorized" do
    use_cassette "orders/create/post_unauthorized" do
      assert ExFtx.Orders.Create.post(@invalid_credentials, @valid_payload) ==
               {:error, "Not logged in"}
    end
  end
end
