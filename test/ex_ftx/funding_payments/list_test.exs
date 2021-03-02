defmodule ExFtx.FundingPayments.ListTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.FundingPayments.List

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
    use_cassette "funding_payments/list/get_ok" do
      assert {:ok, list} = ExFtx.FundingPayments.List.get(@valid_credentials)
      assert Enum.count(list) > 0
      assert %ExFtx.FundingPayment{} = offer = Enum.at(list, 0)
      assert offer.payment != nil
    end
  end

  test ".get/1 unauthorized" do
    use_cassette "funding_payments/list/get_unauthorized" do
      assert ExFtx.FundingPayments.List.get(@invalid_credentials) ==
               {:error, "Not logged in"}
    end
  end
end
