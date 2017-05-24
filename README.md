# Epa

## Installation

  1. Add `epa` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:epa, "~> 0.1.0"}]
    end
    ```

## Usage

In your Application's start/2 function, simply do:

```elixir
defmodule MyApp do
  import EPA

  def start(_, _) do
    required(["ENV_VAR_1", "API_KEY_THING"])
  end
end
```

Now the app will raise an exception on boot if the env vars aren't correctly
set!

Optionally, you can set which env the check is for:

```elixir
defmodule MyApp do
  import EPA

  def start(_, _) do
    required(["ENV_VAR_1", "API_KEY_THING"], :dev)
    required(["ENV_VAR_2", "API_KEY_THING"], :prod)
  end
end
```

### What going on?

&EPA.required/1-2 gets the value out with System.get_env, stripping leading or
trailing whitespace. If the value is nil or "" (after stripping), then an
exception is raised telling you which env vars are missing.
