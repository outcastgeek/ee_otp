defmodule ModernWeb.User do
  use ModernWeb.Web, :model

	alias ModernWeb.Role

  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :confirmed, :boolean, default: false
    field :name, :string
    field :location, :string
    field :about_me, :string
    field :member_since, Ecto.DateTime
    field :last_seen, Ecto.DateTime
    field :avatar_hash, :string

		belongs_to :role, Role
		#field :role_id, :integer
  end

  @required_fields ~w(email username password_hash)
	@optional_fields ~w(confirmed name location about_me member_since last_seen avatar_hash)
	#@required_fields ~w(email username password_hash confirmed name location about_me member_since last_seen avatar_hash)
  #@optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
		|> validate_confirmation(:password_hash, message: "passwords do not match")
		|> validate_strong_password(:password_hash)
		|> validate_length(:about_me, max: 140)
		|> validate_format(:email, ~r/@/)
		|> validate_unique(:email, on: ModernWeb.Repo)
		|> validate_unique(:username, on: ModernWeb.Repo)
  end

	# https://github.com/elixircnx/comeonin/blob/master/lib/comeonin/password.ex
	@alpha Enum.concat ?A..?Z, ?a..?z
  @alphabet ',./!@#$%^&*();:?<>' ++ @alpha ++ '0123456789'
  @digits String.codepoints("0123456789")
  @punc String.codepoints(" ,./!@#$%^&*();:?<>")
	@pass_min_length 8
	
	@doc "Validates Strong Passwords"
	defp validate_strong_password(changeset, field) do
		Ecto.Changeset.validate_change changeset, field, fn
			_, value ->
				result = strong_password?(value)
				case result do
					r when is_binary(r) ->
						[{field, result}]
					_ ->
						[]
				end
		end
	end

	def strong_password?(password) do
    case pass_length?(String.length(password), @pass_min_length) do
      true -> has_punc_digit?(password)
      message -> message
    end
  end

  defp pass_length?(word_len, min_len) when word_len < min_len do
    "The password should be at least #{@pass_min_length} characters long."
  end
  defp pass_length?(_, _), do: true

  defp has_punc_digit?(word) do
    if :binary.match(word, @digits) != :nomatch and :binary.match(word, @punc) != :nomatch do
      true
    else
      "The password should contain at least one number and one punctuation character."
    end
  end

end
