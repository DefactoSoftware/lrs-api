defmodule LrsApi.Statement do
  use LrsApi.Web, :model

  schema "statements" do
    field :actor, :string
    field :verb, :string
    field :object, :string
    field :payload, :map

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:actor, :verb, :object, :payload])
    |> validate_required([:payload])
  end
end
