defmodule LrsApi.StatementView do
  use LrsApi.Web, :view

  def render("index.json", %{statments: statments}) do
    %{data: render_many(statments, LrsApi.StatementView, "statement.json")}
  end

  def render("show.json", %{statement: statement}) do
    %{data: render_one(statement, LrsApi.StatementView, "statement.json")}
  end

  def render("statement.json", %{statement: statement}) do
    %{id: statement.id,
      actor: statement.actor,
      verb: statement.verb,
      object: statement.object,
      payload: statement.payload}
  end
end
