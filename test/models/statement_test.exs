defmodule LrsApi.StatementTest do
  use LrsApi.ModelCase

  alias LrsApi.Statement

  @valid_attrs %{
    actor: "someones@email.com",
    object: "Chapter",
    verb: "passed",
    payload: %{"address" => "Samaipata", "mobile" => "73732677", "age" => 40}
  }
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Statement.changeset(%Statement{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Statement.changeset(%Statement{}, @invalid_attrs)
    refute changeset.valid?
  end
end
