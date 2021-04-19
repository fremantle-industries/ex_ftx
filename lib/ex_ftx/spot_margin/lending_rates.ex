defmodule ExFtx.SpotMargin.LendingRates do
  alias ExFtx.JsonResponse

  @type lending_rate :: ExFtx.LendingRate.t()
  @type result :: {:ok, [lending_rate]} | {:error, :parse_result_item}

  @spec get :: result
  def get() do
    "/spot_margin/lending_rates"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.LendingRate))
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
