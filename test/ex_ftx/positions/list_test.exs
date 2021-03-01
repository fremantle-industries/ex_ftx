defmodule ExFtx.Positions.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.Positions.List

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
    use_cassette "positions/list/get_ok" do
      assert {:ok, positions} = ExFtx.Positions.List.get(@valid_credentials)
      assert Enum.count(positions) > 0
      assert %ExFtx.Position{} = position = Enum.at(positions, 0)
      assert position.entry_price > 0
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "positions/list/get_unauthorized" do
      assert ExFtx.Positions.List.get(@invalid_credentials) == {:error, "Not logged in"}
    end
  end
end
