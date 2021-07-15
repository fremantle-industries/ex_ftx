defmodule ExFtx.JsonResponse do
  alias __MODULE__

  @type error :: String.t()
  @type result :: map | list | String.t()
  @type t :: %JsonResponse{success: boolean, result: result, error: error}

  defstruct ~w[success result error]a
end
