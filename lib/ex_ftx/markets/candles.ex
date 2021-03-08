defmodule ExFtx.Markets.Candles do
  @type market_name :: String.t()
  @type candle :: ExFtx.Candle.t()
  @type resolution :: non_neg_integer
  @type params :: %{
          optional(:limit) => pos_integer,
          optional(:start_time) => pos_integer,
          optional(:end_time) => pos_integer
        }
  @type result :: {:ok, candle} | {:error, :not_found | :parse_result_item | String.t()}

  @spec get(market_name, resolution) :: result
  @spec get(market_name, resolution, params) :: result
  def get(market_name, resolution, params \\ %{}) do
    params = Map.put(params, :resolution, resolution)

    "/markets/#{market_name}/candles"
    |> ExFtx.HTTPClient.non_auth_get(params)
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: trades}}) do
    trades
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Candle, transformations: [:snake_case]))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: "No such market:" <> _}}) do
    {:error, :not_found}
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: reason}}) do
    {:error, reason}
  end
end
