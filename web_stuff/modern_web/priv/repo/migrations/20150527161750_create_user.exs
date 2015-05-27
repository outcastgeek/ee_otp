defmodule ModernWeb.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :password_hash, :string
      add :confirmed, :boolean, default: false
      add :name, :string
      add :location, :string
      add :about_me, :text
      add :member_since, :datetime
      add :last_seen, :datetime
      add :avatar_hash, :string
			add :role_id, references(:roles)
    end

		# Indexing
		create index(:users, [:email], unique: true)
		create index(:users, [:username], unique: true)
		create index(:users, [:name])
		create index(:users, [:role_id])
		create index(:users, [:email, :username, :name, :role_id])

  end
end
