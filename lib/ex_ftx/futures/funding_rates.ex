defmodule ExFtx.Futures.FundingRates do
  @type future_name :: String.t()
  @type funding_rates :: ExFtx.FundingRates.t()
  @type result :: {:ok, funding_rates} | {:error, :parse_result_item}

  @spec get :: result
  def get do
    "/funding_rates"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: funding_rates}}) do
    funding_rates
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.FundingRates))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end
end
