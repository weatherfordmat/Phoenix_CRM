defmodule Cmr.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cmr.Accounts.User

  schema "users" do
    field :email, :string
    field :firstName, :string
    field :lastName, :string
    field :age, :integer
    field :password, :string, virtual: true
    field :password_hash, :string

    timestamps()
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :password])
    |> validate_required([:email])
    |> unique_constraint(:email)
  end

  def create_changeset(%User{} = user, attrs) do
    user
    |> changeset(attrs)
    |> validate_password(:password)
    |> put_pass_hash()
  end

  def validate_password(changeset, field, options \\ []) do
    validate_change(changeset, field, fn _, password ->
      case strong_password?(password) do
        {:ok, _} -> []
        {:error, msg} -> [{field, options[:message] || msg}]
      end
    end)
  end

  def put_pass_hash(%Ecto.Changeset{valid?: true, changes:
      %{password: password}} = changeset) do
    change(changeset, Comeonin.Argon2.add_hash (password))
  end
  def put_pass_hash(changeset), do: changeset

  defp strong_password?(password) when byte_size(password) > 7 do
    {:ok, password}
  end
  defp strong_password?(_), do: {:error, "The password is too short"}
end
