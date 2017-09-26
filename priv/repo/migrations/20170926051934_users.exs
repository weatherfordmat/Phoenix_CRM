defmodule Cmr.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :lastname, :string
      add :note, :string
      add :encrypted_password, :string
      add :email, :string

      timestamps()
    end
  end
end
