defmodule ExFtx.Markets.List do
  @type market :: ExFtx.Market.t()
  @type result :: {:ok, [market]} | {:error, :parse_result_item}

  @spec get :: result
  def get do
    "/markets"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Market, transformations: [:snake_case]))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end
end
