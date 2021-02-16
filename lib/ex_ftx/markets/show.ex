defmodule ExFtx.Markets.Show do
  @type market_name :: String.t()
  @type market :: ExFtx.Market.t()
  @type result :: {:ok, market} | {:error, :parse_result_item}

  @spec get(market_name) :: result
  def get(market_name) do
    "/markets/#{market_name}"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: market}}) do
    market
    |> Mapail.map_to_struct(ExFtx.Market, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end
end
