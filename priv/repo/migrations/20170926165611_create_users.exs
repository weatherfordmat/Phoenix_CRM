defmodule Cmr.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :firstName, :string
      add :lastName, :string
      add :lead, :boolean
      add :age, :integer
      add :password_hash, :string

      timestamps()
    end

    create unique_index :users, [:email]
  end
end
