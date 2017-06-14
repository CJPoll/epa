defmodule EPA do
  defmodule InvalidConfig do
    defexception [:message]
  end

  defmacro __using__(_) do
    quote do
      require EPA
      import EPA
    end
  end

  @type var_name :: String.t
  @type var_value :: String.t
  @type environment :: atom

  @spec required([var_name])
  :: true | no_return
  def required(expected_vars) do
    expected_vars
    |> Enum.map(fn(var) -> {var, System.get_env(var)} end)
    |> EPA.Require.required
  end

  @doc ~S"""
  Does a few things things:
    1. Gets the ENV vars out of the environment
    1. Strips leading and trailing whitespaces from the values
    1. Checks that all values are non-nil, non-empty strings.
    1. Raises an exception on failure

  Optionally takes an atom specifying the environment these vars are required in.
  """
  @spec required([var_name], environment)
  :: true | no_return
  def required(expected_vars, env) when is_atom(env) and is_list(expected_vars) do
    if Mix.env == env do
      required(expected_vars)
    end
  end
end
