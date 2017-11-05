defmodule Cmr.Repo.Migrations.AddLead do
  use Ecto.Migration
  
    def change do
      alter table(:users) do
        add :lead, :boolean
      end
    end
  end
  