defmodule ExFtx.Credentials do
  @type api_key :: String.t()
  @type api_secret :: String.t()
  @type api_subaccount :: String.t() | nil
  @type t :: %__MODULE__{
          api_key: api_key,
          api_secret: api_secret,
          api_subaccount: api_subaccount
        }

  @enforce_keys ~w[api_key api_secret api_subaccount]a
  defstruct ~w[api_key api_secret api_subaccount]a
end
