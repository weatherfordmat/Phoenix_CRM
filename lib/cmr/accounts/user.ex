defmodule Cmr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cmr.Accounts.User


  schema "users" do
    field :name, :string
    field :username, :string
    field :password, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :username, :password])
    |> validate_required([:name, :username, :password])
    |> unique_constraint(:username)
  end
end
