defmodule CmrWeb.UserController do
  use CmrWeb, :controller

  alias Cmr.Accounts
  alias Cmr.Accounts.User

  def order(list, rev) do
    cond do
      rev == "1" ->
        list
      rev == "0" ->
        list |> Enum.reverse()
      rev == nil ->
        list
    end
  end

  def index(conn, params) do
    key = "id"
    users = order(Accounts.list_users(params["sortby"]), params["asc"])
    changeset = Accounts.change_user(%User{})
    render(conn, "index.html", users: users, changeset: changeset)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    users = Accounts.list_users()
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        addInfo(conn,  "User created successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "index.html", users: users, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        addInfo(conn,  "User updated successfully.")
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: user_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    addInfo(conn,  "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end

  def addInfo(conn, opts, color \\ "#1ed9cf", canExit \\ true) do
    conn
    |> put_flash(:info, opts)
    |> put_flash(:exit, canExit)
    |> put_flash(:backgroundColor, color)
  end
end


defmodule QuickSort do
  def sort([]), do: []
  def sort([head|tail]) do
    {lesser, greater} = Enum.partition(tail, &(&1 < head))
    IO.inspect greater
    sort(lesser) ++ [head] ++ sort(greater)
  end
end