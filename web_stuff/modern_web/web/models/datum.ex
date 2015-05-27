defmodule ModernWeb.Datum do
  use ModernWeb.Web, :model

  schema "data" do
    field :key, :string
    field :value, :binary
    field :thing_id, :integer
  end

  @required_fields ~w(key value thing_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
