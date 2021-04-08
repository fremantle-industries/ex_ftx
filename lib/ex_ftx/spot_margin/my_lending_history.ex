defmodule ExFtx.SpotMargin.MyLendingHistory do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type my_lending_history :: ExFtx.MyLendingHistory.t()
  @type result :: {:ok, [my_lending_history]} | {:error, :parse_result_item}

  @spec get(credentials) :: result
  def get(credentials) do
    "/spot_margin/lending_history"
    |> ExFtx.HTTPClient.auth_get(credentials, %{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.MyLendingHistory))
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
