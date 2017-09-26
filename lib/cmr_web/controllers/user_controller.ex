defmodule CmrWeb.UserController do
  use CmrWeb, :controller

  import CmrWeb.Authorize
  alias Phauxth.Log
  alias Cmr.Accounts

  # the following plugs are defined in the controllers/authorize.ex file
  plug :user_check when action in [:index, :show]
  plug :id_check when action in [:edit, :update, :delete]

  def index(conn, _) do
    changeset = Accounts.change_user(%Accounts.User{})
    users = Accounts.list_users()
    render(conn, "index.html", users: users, changeset: changeset)
  end

  def new(conn, _) do
    changeset = Accounts.change_user(%Accounts.User{})
    render(conn, "new.html", changeset: changeset)
  end
  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        Log.info(%Log{user: user.id, message: "user created"})
        success(conn, "User created successfully", session_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        addInfo(conn, "Check the Errors Below", '#f52dcd', true)
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def show(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"id" => id}) do
    user = id == to_string(user.id) and user || Accounts.get(id)
    render(conn, "show.html", user: user)
  end

  def edit(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(%Plug.Conn{assigns: %{current_user: user}} = conn, %{"user" => user_params}) do
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        success(conn, "User updated successfully", user_path(conn, :show, user))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(%Plug.Conn{assigns: %{current_user: user}} = conn, _) do
    {:ok, _user} = Accounts.delete_user(user)
    configure_session(conn, drop: true)
    |> success("User deleted successfully", session_path(conn, :new))
  end

end
