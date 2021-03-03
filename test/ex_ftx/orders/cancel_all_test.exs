defmodule ExFtx.Orders.CancelAllTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Orders.CancelAll

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

  test ".delete/1 ok" do
    use_cassette "orders/cancel_all/delete_ok" do
      assert {:ok, _order_1} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)
      assert {:ok, _order_2} = ExFtx.Orders.Create.post(@valid_credentials, @valid_payload)

      assert ExFtx.Orders.CancelAll.delete(@valid_credentials) == :ok
    end
  end

  test ".delete/1 unauthorized" do
    use_cassette "orders/cancel_all/delete_unauthorized" do
      assert ExFtx.Orders.CancelAll.delete(@invalid_credentials) == {:error, "Not logged in"}
    end
  end
end
