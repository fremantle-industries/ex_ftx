defmodule ExFtx.SpotMargin.BorrowSummary do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type borrow_summary :: ExFtx.BorrowSummary.t()
  @type result :: {:ok, [borrow_summary]} | {:error, :parse_result_item}

  @spec get :: result
  def get do
    "/spot_margin/borrow_summary"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.BorrowSummary))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
