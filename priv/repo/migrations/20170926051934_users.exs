defmodule Cmr.Repo.Migrations.Users do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :lastname, :string
      add :note, :string

      timestamps()
    end
  end
end
