defmodule ExFtx.Markets do
  alias ExFtx.HTTPClient

  @type market :: ExFtx.Market.t()
  @type result :: {:ok, [market]} | {:error, :parse_result_item}

  @path "/markets"

  @spec get :: result
  def get do
    @path
    |> HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %ExFtx.JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Market))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end
end
