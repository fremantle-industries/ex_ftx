defmodule ExFtx.JsonResponse do
  alias __MODULE__

  @type t :: %JsonResponse{success: boolean, result: map | list}

  defstruct ~w[success result]a
end
