defmodule SombreroUiWeb.RenderingHelpers do
  def render_mfa({mod, fun, args}) do
    args_string = args
    |> Enum.map(&inspect/1)
    |> Enum.join(", ")
    "#{mod}.#{fun}(#{args_string})"
  end
end
