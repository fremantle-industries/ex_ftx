defmodule ExFtx.Orders.History do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type order :: ExFtx.Order.t()
  @type result :: {:ok, [order]} | {:error, :parse_result_item}

  @spec get(credentials, ExFtx.Market.name()) :: result
  def get(credentials, market) do
    "/orders/history"
    |> ExFtx.HTTPClient.auth_get(credentials, %{market: market})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: order}}) do
    order
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Order, transformations: [:snake_case]))
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
