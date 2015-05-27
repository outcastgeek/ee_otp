defmodule ModernWeb.Repo.Migrations.CreateDatum do
  use Ecto.Migration

  def change do
    create table(:data) do
      add :key, :string
      add :value, :binary

      add :thing_id, references(:things)
    end

		# Indexing
		create index(:data, [:key])

  end
end
