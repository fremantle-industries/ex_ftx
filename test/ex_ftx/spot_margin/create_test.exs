defmodule ExFtx.SpotMargin.CreateTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.Create

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
  @valid_payload %ExFtx.LendingPayload{
    coin: "USDT",
    size: 0.0001,
    rate: 3.0e-6
  }
  @insufficient_margin_payload Map.put(@valid_payload, :size, 10000.0)
  @invalid_size_payload Map.put(@valid_payload, :size, -0.03)
  @no_such_coin_payload Map.put(@valid_payload, :coin, "invalid")

  test ".post/2 ok" do
    use_cassette "spot_margin/create/post_ok" do
      assert :ok = ExFtx.SpotMargin.Create.post(@valid_credentials, @valid_payload)
    end
  end

  test ".post/2 insufficient margin" do
    use_cassette "spot_margin/create/post_insufficient_margin" do
      assert ExFtx.SpotMargin.Create.post(@valid_credentials, @insufficient_margin_payload) ==
               {:error, "Size too large"}
    end
  end

  test ".post/2 invalid size" do
    use_cassette "spot_margin/create/post_invalid_size" do
      assert ExFtx.SpotMargin.Create.post(@valid_credentials, @invalid_size_payload) ==
               {:error, "Invalid size"}
    end
  end

  test ".post/2 no such coin" do
    use_cassette "spot_margin/create/post_no_such_coin" do
      assert {:error, reason} = ExFtx.SpotMargin.Create.post(@valid_credentials, @no_such_coin_payload)
      assert String.starts_with?(reason, "No such coin:")
    end
  end

  test ".post/2 unauthorized" do
    use_cassette "spot_margin/create/post_unauthorized" do
      assert ExFtx.SpotMargin.Create.post(@invalid_credentials, @valid_payload) ==
               {:error, "Not logged in"}
    end
  end
end
