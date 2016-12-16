defmodule LrsApi.AuthView do
  use LrsApi.Web, :view

  def render("login.json", %{user: user, jwt: jwt, exp: exp}) do
    %{
      data: %{
        user: user, jwt: jwt, exp: exp
      }
    }
  end
end
