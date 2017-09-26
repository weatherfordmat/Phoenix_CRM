defmodule Cmr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cmr.Accounts.User

  schema "users" do
    field :name, :string
    field :lastname, :string
    field :note, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :lastname, :note])
    |> validate_required([:name, :lastname, :note])
    |> validate_length(:name, min: 2)
  end
end
