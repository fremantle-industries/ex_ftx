defmodule ExFtx.Orders.CancelByClientOrderId do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type result :: :ok | {:error, :unhandled_result | String.t()}

  @spec delete(credentials, ExFtx.OrderPayload.client_id()) :: result
  def delete(credentials, client_order_id) do
    "/orders/by_client_id/#{client_order_id}"
    |> ExFtx.HTTPClient.auth_delete(credentials)
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: result}}) do
    result
    |> case do
      "Order queued for cancellation" -> :ok
      _ -> {:error, :unhandled_result}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
