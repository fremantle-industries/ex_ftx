defmodule ExFtx.Auth do
  @type api_secret :: ExFtx.Credentials.api_secret()

  @spec timestamp :: integer
  def timestamp, do: System.os_time(:millisecond)

  @spec sign(api_secret, integer, String.t(), String.t(), term) :: String.t()
  def sign(api_secret, ts, verb, encoded_path, data) do
    payload = "#{ts}#{verb}#{encoded_path}#{data}"

    :sha256
    |> :crypto.hmac(api_secret, payload)
    |> Base.encode16(case: :lower)
  end
end
