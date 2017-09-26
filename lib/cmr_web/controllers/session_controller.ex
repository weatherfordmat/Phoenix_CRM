defmodule CmrWeb.SessionController do
  use CmrWeb, :controller

  import CmrWeb.Authorize
  alias Phauxth.Login

  def new(conn, _) do
    render(conn, "new.html")
  end

  # If you are using Argon2 or Pbkdf2, add crypto: Comeonin.Argon2
  # or crypto: Comeonin.Pbkdf2 to Login.verify (after Accounts)
  def create(conn, %{"session" => params}) do
    case Phauxth.Login.verify(params, Cmr.Accounts, crypto: Comeonin.Argon2) do
      {:ok, user} ->
        put_session(conn, :user_id, user.id)
        |> configure_session(renew: true)
        |> success("You have been logged in", user_path(conn, :index))
      {:error, message} ->
        error(conn, message, session_path(conn, :new))
    end
  end

  def delete(conn, _) do
    configure_session(conn, drop: true)
    |> success("You have been logged out", page_path(conn, :index))
  end
end
