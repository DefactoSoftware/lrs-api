require IO
defmodule LrsApi.User do
  use LrsApi.Web, :model

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]
  import Plug.Conn

  alias LrsApi.Repo
  alias LrsApi.User

  # @derive {Poison.Encoder, only:
  schema "users" do
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def find_and_confirm_password(%{"email" => email,
                                  "password" => given_password}) do
    user = Repo.get_by!(User, email: email)
    if user && checkpw(given_password, user.password_hash) do
      {:ok, user}
    else
      {:error, %{error: "error"}}
    end
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:email, :password_hash])
  end

  def registration_changeset(model, params) do
    model
    |> changeset(params)
    |> cast(params, ~w(password), [])
    |> validate_length(:password, min: 6)
    |> put_password_hash()
  end


  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash,
                   Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
end
