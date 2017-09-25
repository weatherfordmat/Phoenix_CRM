defmodule CmrWeb.PageController do
  use CmrWeb, :controller

  def getName(conn, params) do
    if params["name"], do: "Welcome " <> params["name"] <> ", to my CRM", else: 'Welcome to my CRM!'
  end

  def getKeys(val) do
    val |> Map.keys |> Enum.join(",")
  end

  def index(conn, params) do
    addInfo(conn, "Sample Message")
    |> assign(:name, getName(conn, params))
    |> assign(:hello, "goose")
    |> assign(:data, %{"bar" => 2, "baz" => 0, "foo" => 1})
    |> render("index.html")
  end

  def addInfo(conn, opts, color \\ "#1ed9cf", canExit \\ true) do
    conn
    |> put_flash(:info, opts)
    |> put_flash(:exit, canExit)
    |> put_flash(:backgroundColor, color)
  end

end
