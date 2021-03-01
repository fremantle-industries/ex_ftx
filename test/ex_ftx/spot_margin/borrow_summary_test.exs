defmodule ExFtx.SpotMargin.BorrowSummaryTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney
  doctest ExFtx.SpotMargin.BorrowSummary

  setup_all do
    HTTPoison.start()
    :ok
  end

  test ".get/1 ok" do
    use_cassette "spot_margin/borrow_summary/get_ok" do
      assert {:ok, borrow_summary} = ExFtx.SpotMargin.BorrowSummary.get()
      assert Enum.count(borrow_summary) > 0
      assert %ExFtx.BorrowSummary{} = borrow_summary = Enum.at(borrow_summary, 0)
      assert borrow_summary.size != nil
    end
  end
end
