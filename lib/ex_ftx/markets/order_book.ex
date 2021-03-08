defmodule ExFtx.Markets.OrderBook do
  @type market_name :: String.t()
  @type order_book :: ExFtx.OrderBook.t()
  @type params :: %{optional(:depth) => pos_integer}
  @type result :: {:ok, order_book} | {:error, :not_found | :parse_result_item | String.t()}

  @spec get(market_name) :: result
  @spec get(market_name, params) :: result
  def get(market_name, params \\ %{}) do
    "/markets/#{market_name}/orderbook"
    |> ExFtx.HTTPClient.non_auth_get(params)
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: order_book}}) do
    order_book
    |> Mapail.map_to_struct(ExFtx.OrderBook)
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: "No such market: " <> _}}) do
    {:error, :not_found}
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: reason}}) do
    {:error, reason}
  end
end
