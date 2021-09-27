defmodule ExFtx.SpotMargin.Create do
  alias ExFtx.JsonResponse

  @type credentials :: ExFtx.Credentials.t()
  @type lending_payload :: ExFtx.LendingPayload.t()
  @type result :: :ok | {:error, String.t() | :parse_result_item}

  @spec post(credentials, lending_payload) :: result
  def post(credentials, lending_payload) do
    "/spot_margin/offers"
    |> ExFtx.HTTPClient.auth_post(credentials, to_payload(lending_payload))
    |> parse_response()
  end

  defp to_payload(lending_payload) do
    lending_payload
    |> Map.from_struct()
    |> ProperCase.to_camel_case()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: nil}}), do: :ok
  defp parse_response({:ok, %JsonResponse{success: false, error: error}}), do: {:error, error}
end
