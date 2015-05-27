defmodule ModernWeb.Repo.Migrations.CreateRole do
  use Ecto.Migration

  def change do
    create table(:roles) do
      add :name, :string
      add :default, :boolean, default: false
      add :permissions, :integer
    end

		# Indexing
		create index(:roles, [:name])

  end
end
