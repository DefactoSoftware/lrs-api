require IEx;
defmodule LrsApi.StatementController do
  use LrsApi.Web, :controller

  alias LrsApi.Statement

  def index(conn, _params) do
    statments = Statement |> LrsApi.Repo.all
    json conn, statments.to_json
  end

  def show(conn, %{"id" => id}) do
    json conn, %{id: id}
  end

  def create(conn, params) do
    changeset = Statement.changeset(%Statement{}, %{payload: params})
    LrsApi.Repo.insert(changeset)
    json conn, %{ status: :ok}
  end
end
