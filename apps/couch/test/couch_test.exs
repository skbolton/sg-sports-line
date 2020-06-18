defmodule CouchTest do
  use ExUnit.Case
  doctest Couch

  test "greets the world" do
    assert Couch.hello() == :world
  end
end
