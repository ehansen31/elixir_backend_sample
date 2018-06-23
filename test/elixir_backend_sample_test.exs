defmodule ElixirBackendSampleTest do
  use ExUnit.Case
  doctest ElixirBackendSample

  test "greets the world" do
    assert ElixirBackendSample.hello() == :world
  end
end
