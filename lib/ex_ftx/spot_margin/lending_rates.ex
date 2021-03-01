defmodule ExFtx.SpotMargin.LendingRates do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type lending_rate :: ExFtx.LendingRate.t()
  @type result :: {:ok, [lending_rate]} | {:error, :parse_result_item}

  @spec get(credentials) :: result
  def get(credentials) do
    "/spot_margin/borrow_rates"
    |> ExFtx.HTTPClient.auth_get(credentials, %{})
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
