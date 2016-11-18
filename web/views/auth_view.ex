defmodule LrsApi.AuthView do
  use LrsApi.Web, :view

  def render("login.json", %{user: user, jwt: jwt}) do
    %{
      data: %{
        user: user, jwt: jwt
      }
    }
  end
end
