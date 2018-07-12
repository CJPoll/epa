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

  @type env_var :: String.t
  @type environment :: atom

  @spec required([env_var])
  :: true | no_return
  def required(expected_vars) do
    expected_vars
    |> Enum.map(fn(var) -> {var, System.get_env(var)} end)
    |> EPA.Require.required
  end

  @doc ~S"""
  Does a few things:
    1. Gets the ENV vars out of the environment
    1. Strips leading and trailing whitespaces from the values
    1. Checks that all values are non-nil, non-empty strings.
    1. Raises an exception on failure

  Optionally takes an atom or list of atoms specifying the environment these vars are required in.
  """
  @spec required([env_var], environment)
  :: true | no_return
  def required(expected_vars, env) when is_list(expected_vars) do
    if required_for_env?(env) do
      required(expected_vars)
    end
  end

  @spec required_for_env?(atom | [atom]) :: boolean
  defp required_for_env?(env) when is_atom(env), do: Mix.env == env
  defp required_for_env?(env) when is_list(env), do: Enum.member?(env, Mix.env)
end
