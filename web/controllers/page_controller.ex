defmodule LrsApi.PageController do
  use LrsApi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
