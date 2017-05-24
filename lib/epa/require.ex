defmodule EPA.Require do
  @spec required([{EPA.var_name, EPA.var_value}])
  :: true | no_return
  def required(vars) do
    errors =
      vars
      |> Enum.map(fn({name, value}) -> {name, strip(value)} end)
      |> Enum.reduce([], &validate/2)
      |> Enum.reverse

    if errors?(errors) do
      msg =
        errors
        |> Enum.map(fn({name, _value}) ->
             "System.get_env(\"#{name}\") is not set correctly"
           end)
        |> Enum.join("\n")

      raise EPA.InvalidConfig, msg
    end

    true
  end

  @spec strip(EPA.maybe(EPA.var_value)) :: EPA.maybe(EPA.var_value)
  def strip(nil), do: nil
  def strip(str) do
    str
    |> String.trim_leading
    |> String.trim_trailing
  end

  defp validate({_, nil} = elem, errors), do: [elem | errors]
  defp validate({_, ""} = elem, errors), do: [elem | errors]
  defp validate({_, val}, errors) when is_binary(val), do: errors

  defp errors?([]), do: false
  defp errors?(errors) when is_list(errors), do: true
end
