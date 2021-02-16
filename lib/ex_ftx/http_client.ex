defmodule ExFtx.HTTPClient do
  @type verb :: :get | :post | :put | :delete
  @type params :: map
  @type path :: String.t()
  @type uri :: String.t()
  @type non_auth_response :: term
  @type auth_response :: term

  @spec domain :: String.t()
  def domain, do: Application.get_env(:ex_ftx, :domain, "ftx.com")

  @spec protocol :: String.t()
  def protocol, do: Application.get_env(:ex_ftx, :protocol, "https://")

  @spec origin :: String.t()
  def origin, do: protocol() <> domain()

  @spec url(uri :: String.t()) :: String.t()
  def url(uri), do: origin() <> uri

  @spec api_path :: String.t()
  def api_path, do: Application.get_env(:ex_ftx, :api_path, "/api")

  @spec non_auth_get(path, params) :: non_auth_response
  def non_auth_get(path, params \\ %{}) do
    non_auth_request(:get, path |> to_uri(params))
  end

  @spec non_auth_request(verb, uri) :: non_auth_response
  def non_auth_request(verb, uri) do
    headers = [] |> put_content_type(:json)

    %HTTPoison.Request{
      method: verb,
      url: url(uri),
      headers: headers
    }
    |> send
  end

  defp to_uri(path, params) do
    %URI{
      path: api_path() <> path,
      query: URI.encode_query(params)
    }
    |> URI.to_string()
  end

  defp put_content_type(headers, :json) do
    Keyword.put(headers, :"Content-Type", "application/json")
  end

  defp send(request) do
    request
    |> HTTPoison.request()
    |> parse_response
  end

  defp parse_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, json} = Jason.decode(body)

    {:ok, rpc_response} =
      Mapail.map_to_struct(json, ExFtx.JsonResponse, transformations: [:snake_case])

    {:ok, rpc_response}
  end
end
