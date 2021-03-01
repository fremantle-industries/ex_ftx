defmodule ExFtx.JsonResponse do
  alias __MODULE__

  @type error :: String.t()
  @type t :: %JsonResponse{success: boolean, result: map | list, error: error}

  defstruct ~w[success result error]a
end
