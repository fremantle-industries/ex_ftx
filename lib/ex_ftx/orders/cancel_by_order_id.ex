defmodule ExFtx.Orders.CancelByOrderId do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type result :: :ok | {:error, :unhandled_result}

  @spec delete(credentials, ExFtx.Order.id()) :: result
  def delete(credentials, order_id) do
    "/orders/#{order_id}"
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
