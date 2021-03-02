defmodule ExFtx.Wallet.AllBalances do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type balance :: ExFtx.Balance.t()
  @type result :: {:ok, [balance]} | {:error, :parse_result_item}

  @spec get(credentials) :: result
  def get(credentials) do
    "/wallet/all_balances"
    |> ExFtx.HTTPClient.auth_get(credentials, %{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: all_balances}}) do
    all_balances
    |> Enum.reduce(
      {:ok, %{}},
      fn
        {account_name, balances}, {:ok, acc} ->
          balances
          |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.Balance, transformations: [:snake_case]))
          |> case do
            {:ok, balance} -> {:ok, Map.put(acc, account_name, balance)}
            _ -> {:error, :parse_result_item}
          end

        # _, _acc ->
        i, acc ->
          IO.puts("---------- ITEM: #{inspect(i)}")
          IO.puts("---------- acc: #{inspect(acc)}")
          {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
