defmodule EPA.Require.Test do
  use ExUnit.Case
  @test_module EPA.Require

  doctest @test_module

  describe "strip/1" do
    test "Accepts a nil" do
      @test_module.strip(nil)
    end

    test "Accepts a string" do
      @test_module.strip("hello!")
    end

    test "returns nil on nil" do
      assert @test_module.strip(nil) == nil
    end

    test "trims leading whitespaces" do
      assert @test_module.strip("\n\t   hi!") == "hi!"
    end

    test "trims trailing whitespaces" do
      assert @test_module.strip("hi!\n\t   ") == "hi!"
    end

    test "trims leading and trailing whitespaces" do
      assert @test_module.strip("\n\t    hi!\t   \n") == "hi!"
    end
  end

  describe "required/2" do
    test "accepts a proplist (String => String)" do
      @test_module.required([{"abc", "123"}])
    end

    test "raises if a value is nil" do
      assert_raise EPA.InvalidConfig, error_message(["abc"]), fn ->
        @test_module.required([{"abc", nil}])
      end
    end

    test "raises if a value is an empty string" do
      assert_raise EPA.InvalidConfig, error_message(["abc"]), fn ->
        @test_module.required([{"abc", ""}])
      end
    end

    test "raises if a value is a string with only whitespace" do
      assert_raise EPA.InvalidConfig, error_message(["abc"]), fn ->
        @test_module.required([{"abc", "\n\t   "}])
      end
    end

    test "raises error message for all invalid values" do
      assert_raise EPA.InvalidConfig, error_message(["abc", "jkl"]), fn ->
        @test_module.required([{"abc", nil}, {"def", "ghi"}, {"jkl", nil}])
      end
    end
  end

  @type error_message :: String.t
  @type name :: String.t

  @spec error_message([name]) :: error_message
  defp error_message(names) do
    names
    |> Enum.map(&"System.get_env(\"#{&1}\") is not set correctly")
    |> Enum.join("\n")
  end
end
