defmodule ExFtx.Fills.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Fills.List

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

  test ".get/1 ok" do
    use_cassette "fills/list/get_ok" do
      assert {:ok, list} = ExFtx.Fills.List.get(@valid_credentials)
      assert Enum.count(list) > 0
      assert %ExFtx.Fill{} = offer = Enum.at(list, 0)
      assert offer.fee_currency != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "fills/list/get_unauthorized" do
      assert ExFtx.Fills.List.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
