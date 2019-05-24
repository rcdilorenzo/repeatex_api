defmodule RepeatexApi.ApiController do
  use RepeatexApi.Web, :controller

  def parse(conn, %{"value" => value, "date" => raw_date}) when is_binary(value) do
    _parse(conn, value, parsed_date(raw_date))
  end

  def parse(conn, %{"value" => value}) when is_binary(value) do
    date = :erlang.universaltime() |> Tuple.to_list |> Enum.at(0)
    _parse(conn, value, date)
  end

  defp _parse(conn, value, date) do
    parsed = Repeatex.parse(value)
    formatted = case parsed do
      nil -> ""
      parsed -> Repeatex.description(parsed)
    end
    json conn, %{
      parsed: parsed,
      formatted: formatted,
      current: current_date(),
      dates: dates_for_next_two_months(parsed, date)}
  end

  defp parsed_date(raw_date) do
    raw_date |> String.split("-") |> Enum.map(&String.to_integer/1) |> List.to_tuple
  end

  defp dates_for_next_two_months(nil, _date), do: []
  defp dates_for_next_two_months(parsed, date) do
    final_date = :edate.shift(date, 3, :month) |> :edate.end_of_month
    dates_until(parsed, date, final_date, [date_to_string(date)])
  end

  defp dates_until(parsed, date, final_date, dates) do
    next = Repeatex.next_date(parsed, date)
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
