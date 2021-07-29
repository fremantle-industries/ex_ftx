defmodule ExFtx.JsonResponse do
  @type error :: String.t()
  @type result :: map | list | String.t()
  @type t :: %__MODULE__{success: boolean, result: result, error: error}

  defstruct ~w[success result error]a
end
