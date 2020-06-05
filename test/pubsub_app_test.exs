defmodule PubsubAppTest do
  use ExUnit.Case
  doctest PubsubApp

  test "greets the world" do
    assert PubsubApp.hello() == :world
  end
end
