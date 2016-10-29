require IEx;
defmodule LrsApi.StatementController do
  use LrsApi.Web, :controller

  alias LrsApi.Repo
  alias LrsApi.Statement

  def index(conn, _params) do
    statments = Repo.all(Statement)
    render(conn, "index.json", statments: statments)
  end

  def create(conn, params) do
    payload = params["statement"]
    actor = payload["actor"]["mbox"]
    verb = payload["verb"]["display"]["en-US"]
    object = payload["object"]["definition"]["name"]["en-US"]
    IO.puts actor
    IO.puts verb
    IO.puts object
    changeset = Statement.changeset(%Statement{}, %{
                                    payload: payload,
                                    verb: verb,
                                    actor: actor,
                                    object: object
                                  })

    case Repo.insert(changeset) do
      {:ok, statement} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", statement_path(conn, :show, statement))
        |> render("show.json", statement: statement)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LrsApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    statement = Repo.get!(Statement, id)
    render(conn, "show.json", statement: statement)
  end

  def update(conn, %{"id" => id, "statement" => statement_params}) do
    statement = Repo.get!(Statement, id)
    changeset = Statement.changeset(statement, statement_params)

    case Repo.update(changeset) do
      {:ok, statement} ->
        render(conn, "show.json", statement: statement)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(LrsApi.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    statement = Repo.get!(Statement, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(statement)

    send_resp(conn, :no_content, "")
  end
end
