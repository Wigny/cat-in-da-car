defmodule CatInDaCarTest do
  use ExUnit.Case
  doctest CatInDaCar

  test "greets the world" do
    assert CatInDaCar.hello() == :world
  end
end
