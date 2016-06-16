defmodule RepeatexApi.ApiController do
  use RepeatexApi.Web, :controller

  def parse(conn, %{"value" => value}) when is_binary(value) do
    parsed = Repeatex.parse(value)
    formatted = case parsed do
      nil -> ""
      parsed -> Repeatex.description(parsed)
    end
    json conn, %{
      parsed: parsed,
      formatted: formatted,
      current: current_date,
      dates: dates_for_next_two_months(parsed)}
  end

  defp dates_for_next_two_months(nil), do: []
  defp dates_for_next_two_months(parsed) do
    {today, _} = :erlang.universaltime
    final_date = :edate.shift(today, 3, :month) |> :edate.end_of_month
    dates_until(parsed, today, final_date, [date_to_string(today)])
  end

  defp dates_until(parsed, date, final_date, dates \\ []) do
    next = {year, month, day} = Repeatex.next_date(parsed, date)
    cond do
      length(dates) > 120 ->
        dates
      :edate.is_after(next, final_date) ->
        dates
      true ->
        dates_until(parsed, next, final_date, dates ++ [date_to_string(next)])
    end
  end

  defp date_to_string({year, month, day}) do
    "#{String.rjust(to_string(month), 2, ?0)}/#{String.rjust(to_string(day), 2, ?0)}/#{year}"
  end

  defp current_date do
    {mega, seconds, ms} = :os.timestamp
    (mega*1000000 + seconds)*1000 + :erlang.round(ms/1000)
  end
end
