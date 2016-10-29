defmodule LrsApi.Repo.Migrations.CreateStatement do
  use Ecto.Migration

  def change do
    create table(:statments) do
      add :actor, :string
      add :verb, :string
      add :object, :string
      add :payload, :map

      timestamps()
    end

  end
end
