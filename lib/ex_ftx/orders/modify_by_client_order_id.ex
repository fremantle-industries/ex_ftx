defmodule ExFtx.Orders.ModifyByClientOrderId do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type modify_payload :: ExFtx.ModifyOrderByClientIdPayload.t()
  @type order :: ExFtx.Order.t()
  @type result :: {:ok, [order]} | {:error, :parse_result_item}

  @spec post(credentials, ExFtx.Order.id(), modify_payload) :: result
  def post(credentials, client_order_id, modify_payload) do
    "/orders/by_client_id/#{client_order_id}/modify"
    |> ExFtx.HTTPClient.auth_post(credentials, to_venue_payload(modify_payload))
    |> parse_response()
  end

  defp to_venue_payload(modify_payload) do
    modify_payload
    |> Map.from_struct()
    |> ProperCase.to_camel_case()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: order}}) do
    order
    |> Mapail.map_to_struct(ExFtx.Order, transformations: [:snake_case])
    |> case do
      {:ok, _} = result -> result
      _ -> {:error, :parse_result_item}
    end
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
