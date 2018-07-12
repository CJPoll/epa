ExUnit.start()

defmodule EPA.TestHelpers do
  @type error_message :: String.t
  @type name :: String.t

  @spec error_message([name]) :: error_message
  def error_message(names) do
    names
    |> Enum.map(&"System.get_env(\"#{&1}\") is not set correctly")
    |> Enum.join("\n")
  end
end
