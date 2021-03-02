defmodule ExFtx.Fills.List do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type fill :: ExFtx.Fill.t()
  @type result :: {:ok, [fill]} | {:error, :parse_result_item}

  @spec get(credentials) :: result
  def get(credentials) do
    "/fills"
    |> ExFtx.HTTPClient.auth_get(credentials, %{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Fill, transformations: [:snake_case]))
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
