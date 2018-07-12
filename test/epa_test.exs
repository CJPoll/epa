defmodule EPA.Test do
  use ExUnit.Case
  import EPA.TestHelpers

  @test_module EPA

  doctest @test_module

  describe "required/2" do
    test "should not raise if expected env is set" do
      System.put_env("set_env", "set")
      @test_module.required(["set_env"])
    end

    test "raises with expected env missing" do
      assert_raise EPA.InvalidConfig, error_message(["abc"]), fn ->
        @test_module.required(["abc"])
      end
    end

    test "should not raise if not required for current environment" do
      @test_module.required(["abc"], :dev)
    end

    test "supports a list of environments" do
      @test_module.required(["abc"], [:dev, :prod])
    end

    test "raises if expected env is not set in current environment" do
      assert_raise EPA.InvalidConfig, error_message(["abc"]), fn ->
        @test_module.required(["abc"], [:test, :prod])
      end
    end
  end
end
