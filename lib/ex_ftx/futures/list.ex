defmodule ExFtx.Futures.List do
  @type market :: ExFtx.Future.t()
  @type result :: {:ok, [market]} | {:error, :parse_result_item}

  @spec get :: result
  def get do
    "/futures"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{result: futures}}) do
    futures
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Future, transformations: [:snake_case]))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end
end
