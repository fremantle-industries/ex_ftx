defmodule ExFtx.SpotMargin.MarketInfo do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type market_info :: ExFtx.MarketInfo.t()
  @type market :: String.t()
  @type result :: {:ok, [market_info]} | {:error, :parse_result_item}

  @spec get(credentials, market) :: result
  def get(credentials, market) do
    "/spot_margin/market_info"
    |> ExFtx.HTTPClient.auth_get(credentials, %{market: market})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.MarketInfo, transformations: [:snake_case]))
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
