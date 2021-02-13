defmodule ExFtx.Futures.Stats do
  @type future_name :: String.t()
  @type future_stats :: ExFtx.FutureStats.t()
  @type result :: {:ok, future_stats} | {:error, :parse_result_item}

  @spec get(future_name) :: result
  def get(future_name) do
    "/futures/#{future_name}/stats"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: stats}}) do
    stats
    |> Mapail.map_to_struct(ExFtx.FutureStats, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end
end
