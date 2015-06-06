defmodule ModernWeb.Web.AuthService do
  @moduledoc """
  Auth Service to Provide Auth Functionality
  """
	alias ModernWeb.Role
	alias ModernWeb.User
  # Alias the data repository and import query/model functions
  alias ModernWeb.Repo
  import Ecto.Model
  import Ecto.Query, only: [from: 2]


	alias Utils.Crypto
	alias ModernWeb.PermissionService

	@doc "Securedly creates a new User with the Most Basic Role"
	def create(user_data) do
		user_data
		|> hash_password_in_user_data
		|> assign_basic_user_role
		|> (&(Repo.insert(struct(User, &1)))).()
	end

	@doc "Authenticates using Provided Creds"
  def authenticate(user_data) do
		user_data
		|> hash_password_in_user_data
		|> (&(Repo.get_by(User, &1))).()
	end

	defp hash_password_in_user_data(user_data) do
		user_data
		|> (fn data ->
			    {:ok, hashed_pwd} = Comeonin.create_hash(data[:password_hash])
					put_in(data, [:password_hash], hashed_pwd)
		    end).()
		#|> (&(put_in(&1, [:password_hash], Crypto.md5(&1[:password_hash])))).()
	end

	defp assign_basic_user_role(user_data) do
		user_data
		|> (&(put_in(&1, [:role_id], PermissionService.get_most_basic_role().id))).()
	end
end
