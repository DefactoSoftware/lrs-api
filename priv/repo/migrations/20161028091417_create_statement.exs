defmodule LrsApi.Repo.Migrations.CreateStatement do
  use Ecto.Migration

  def change do
    create table(:statements) do
      add :actor, :string
      add :verb, :string
      add :object, :string
      add :payload, :json

      timestamps()
    end

  end
end
