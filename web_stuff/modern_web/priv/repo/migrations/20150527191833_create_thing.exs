defmodule ModernWeb.Repo.Migrations.CreateThing do
  use Ecto.Migration

  def change do
    create table(:things) do
      add :name, :string
      add :score, :integer
      add :version, :integer
			add :user_id, references(:users)
    end

		# Indexing
		create index(:things, [:name])
		create index(:things, [:score])
		create index(:things, [:version])
		create index(:things, [:user_id])
		create index(:things, [:name, :score, :version, :user_id])

  end
end
