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
  @type maybe(t) :: t | nil

  @doc ~S"""
  Takes a list of ENV Var names (Strings), gets the ENV vars out of the
  environment, strips leading and trailing whitespaces from the values, and
  checks that all values are non-empty strings.

  Optionally takes an atom specifying the environment these vars are required in.
  """
  @spec required([var_name])
  :: true | no_return
  def required(expected_vars) do
    expected_vars
    |> Enum.map(fn(var) -> {var, System.get_env(var)} end)
    |> EPA.Require.required
  end

  def required(expected_vars, env) when is_atom(env) and is_list(expected_vars) do
    if Mix.env == env do
      required(expected_vars)
    end
  end
end
