defmodule ExFtx.Wallet.Coins do
  alias ExFtx.JsonResponse

  @type coin :: ExFtx.Coin.t()
  @type result :: {:ok, [coin]} | {:error, :parse_result_item}

  @spec get :: result
  def get do
    "/wallet/coins"
    |> ExFtx.HTTPClient.non_auth_get(%{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: coins}}) do
    coins
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Coin, transformations: [:snake_case]))
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
