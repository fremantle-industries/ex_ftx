defmodule ExFtx.Markets.Trades do
  @type market_name :: String.t()
  @type order_book :: ExFtx.Trade.t()
  @type result :: {:ok, order_book} | {:error, :parse_result_item}

  @spec get(market_name) :: result
  @spec get(market_name, map) :: result
  def get(market_name, params \\ %{}) do
    "/markets/#{market_name}/trades"
    |> ExFtx.HTTPClient.non_auth_get(params)
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: trades}}) do
    trades
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Trade, transformations: [:snake_case]))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end
end
