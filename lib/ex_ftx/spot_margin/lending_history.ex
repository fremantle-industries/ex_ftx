defmodule ExFtx.SpotMargin.LendingHistory do
  @moduledoc """
  Get lending history

  https://docs.ftx.com/#get-lending-history
  """

  alias ExFtx.JsonResponse

  @type lending_history :: ExFtx.LendingHistory.t()
  @type params :: %{
          optional(:coin) => String.t(),
          optional(:start_time) => non_neg_integer,
          optional(:end_time) => non_neg_integer
        }
  @type result :: {:ok, [lending_history]} | {:error, :parse_result_item}

  @spec get(params) :: result
  def get(params \\ %{}) do
    "/spot_margin/history"
    |> ExFtx.HTTPClient.non_auth_get(params)
    |> parse_response()
  end

  defp parse_response({:ok, %JsonResponse{success: true, result: markets}}) do
    markets
    |> Enum.map(&Mapail.map_to_struct(&1, ExFtx.LendingHistory))
    |> Enum.reduce(
      {:ok, []},
      fn
        {:ok, i}, {:ok, acc} -> {:ok, [i | acc]}
        _, _acc -> {:error, :parse_result_item}
      end
    )
  end

  defp parse_response({:ok, %JsonResponse{success: false, error: error}}) do
    {:error, error}
  end
end
