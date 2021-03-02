defmodule ExFtx.Account.Show do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type account :: ExFtx.Account.t()
  @type result :: {:ok, account} | {:error, JsonResponse.error(), :parse_result_item}

  @spec get(credentials) :: result
  def get(credentials) do
    "/account"
    |> ExFtx.HTTPClient.auth_get(credentials, %{})
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: account}}) do
    account
    |> Mapail.map_to_struct(ExFtx.Account, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
