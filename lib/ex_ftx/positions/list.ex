defmodule ExFtx.Positions.List do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type position :: ExFtx.Position.t()
  @type result :: {:ok, [position]} | {:error, :parse_result_item}

  @spec get(credentials) :: result
  @spec get(credentials, boolean) :: result
  def get(credentials, show_avg_price \\ false) do
    "/positions"
    |> ExFtx.HTTPClient.auth_get(credentials, %{showAvgPrice: show_avg_price})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Position, transformations: [:snake_case]))
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
