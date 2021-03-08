defmodule ExFtx.Futures.FundingRates do
  @type future_name :: String.t()
  @type funding_rate :: ExFtx.FundingRate.t()
  @type params :: %{
          optional(:future) => String.t(),
          optional(:start_time) => non_neg_integer,
          optional(:end_time) => non_neg_integer
        }
  @type result :: {:ok, [funding_rate]} | {:error, :not_found | :parse_result_item | String.t()}

  @spec get :: result
  @spec get(params) :: result
  def get(params \\ %{}) do
    "/funding_rates"
    |> ExFtx.HTTPClient.non_auth_get(params)
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: funding_rates}}) do
    funding_rates
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.FundingRate))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: "No such future:" <> _}}) do
    {:error, :not_found}
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: false, error: reason}}) do
    {:error, reason}
  end
end
