defmodule NewsApp.User do
  use Ecto.Model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string
    timestamps([{:inserted_at, :created_at}])
  end
end

