defmodule RihannaUiWeb.RenderingHelpers do
  def render_mfa({mod, fun, args}) do
    args_string = args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
    "#{mod}.#{fun}(#{args_string})"
  end

  def render_datetime(%{year: year, month: month, day: day, hour: hour, minute: minute, second: second, zone_abbr: zone_abbr}) do
   datetime_string = :io_lib.format("~4..0B-~2..0B-~2..0B ~2..0B:~2..0B:~2..0B",
     [year, month, day, hour, minute, second])
     |> List.flatten
     |> to_string

    "#{datetime_string} #{zone_abbr}"
 end
end
