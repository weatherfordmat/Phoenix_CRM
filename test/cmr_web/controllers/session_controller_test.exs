defmodule CmrWeb.SessionControllerTest do
  use CmrWeb.ConnCase

  import CmrWeb.AuthCase

  @create_attrs %{email: "robin@example.com", password: "reallyHard2gue$$"}
  @invalid_attrs %{email: "robin@example.com", password: "cannotGue$$it"}

  setup %{conn: conn} do
    conn = conn |> bypass_through(CmrWeb.Router, [:browser]) |> get("/")
    user = add_user("robin@example.com")
    {:ok, %{conn: conn, user: user}}
  end

  test "login succeeds", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @create_attrs
    assert redirected_to(conn) == user_path(conn, :index)
  end

  test "login fails for invalid password", %{conn: conn} do
    conn = post conn, session_path(conn, :create), session: @invalid_attrs
    assert redirected_to(conn) == session_path(conn, :new)
  end

  test "logout succeeds", %{conn: conn, user: user} do
    conn = conn |> put_session(:user_id, user.id) |> send_resp(:ok, "/")
    conn = delete conn, session_path(conn, :delete, user)
    assert redirected_to(conn) == page_path(conn, :index)
  end
end
