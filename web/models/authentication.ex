defmodule LrsApi.Authentication do
  use LrsApi.Web, :model

  schema "authentications" do
    field :provider, :string
    field :uid, :string
    field :token, :string
    field :refresh_token, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:provider, :uid, :token, :refresh_token])
    |> validate_required([:provider, :uid, :token, :refresh_token])
  end
end
