defmodule LrsApi.StatementControllerTest do
  use LrsApi.ConnCase

  alias LrsApi.Statement
  @valid_attrs %{actor: "some content", object: "some content", payload: %{}, verb: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, statement_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    statement = Repo.insert! %Statement{}
    conn = get conn, statement_path(conn, :show, statement)
    assert json_response(conn, 200)["data"] == %{"id" => statement.id,
      "actor" => statement.actor,
      "verb" => statement.verb,
      "object" => statement.object,
      "payload" => statement.payload}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, statement_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, statement_path(conn, :create), statement: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Statement, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, statement_path(conn, :create), statement: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    statement = Repo.insert! %Statement{}
    conn = put conn, statement_path(conn, :update, statement), statement: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Statement, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    statement = Repo.insert! %Statement{}
    conn = put conn, statement_path(conn, :update, statement), statement: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    statement = Repo.insert! %Statement{}
    conn = delete conn, statement_path(conn, :delete, statement)
    assert response(conn, 204)
    refute Repo.get(Statement, statement.id)
  end
end
