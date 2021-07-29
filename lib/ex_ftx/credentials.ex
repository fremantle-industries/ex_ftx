defmodule ExFtx.Credentials do
  @type api_key :: String.t()
  @type api_secret :: String.t()
  @type t :: %__MODULE__{
          api_key: api_key,
          api_secret: api_secret
        }

  @enforce_keys ~w[api_key api_secret]a
  defstruct ~w[api_key api_secret]a
end
