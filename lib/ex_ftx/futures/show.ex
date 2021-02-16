defmodule ExFtx.Futures.Show do
  @type future_name :: String.t()
  @type future :: ExFtx.Future.t()
  @type result :: {:ok, future} | {:error, :parse_result_item}

  @spec get(future_name) :: result
  def get(future_name) do
    "/futures/#{future_name}"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: future}}) do
    future
    |> Mapail.map_to_struct(ExFtx.Future, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end
end
