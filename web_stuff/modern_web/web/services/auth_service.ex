defmodule ModernWeb.Web.AuthService do
	@moduledoc """
  Auth Service to Provide Auth Functionality
  """

	alias ModernWeb.Web.AuthWorker
	
	use GenServer

	######
	# External API

	def start_link(state) do
		GenServer.start_link(__MODULE__, state,
												 debug: [:trace, :statistics]
		)
	end

	def init(state) do
		{:ok, state}
	end

	def create(user_data) do
		:poolboy.transaction(:auth_service, fn(worker) ->
			GenServer.call worker, {:create, user_data}
		end)
	end

	def authenticate(user_data) do
		:poolboy.transaction(:auth_service, fn(worker) ->
			GenServer.call worker, {:authenticate, user_data}
		end)
	end

	def can(user_data, permissions) do
		:poolboy.transaction(:auth_service, fn(worker) ->
			GenServer.call worker, {:can, {user_data, permissions}}
		end)
	end

	#####
	# GenServer Implementation

	def handle_call({:create, user_data}, _from, state) do
		{:reply, AuthWorker.create(user_data), state}
	end

	def handle_call({:authenticate, user_data}, _from, state) do
		{:reply, AuthWorker.authenticate(user_data), state}
	end

	def handle_call({:can, {user_data, permissions}}, _from, state) do
		{:reply, AuthWorker.can(user_data, permissions), state}
	end
end

defmodule ModernWeb.Web.AuthWorker do
  @moduledoc """
  Auth Service Worker
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
		|> verify_user
	end

	@doc "Checks the User Permission"
	def can(user_data, permissions) do
		user = Repo.get_by(User, Map.merge(user_data, %{confirmed: true})) |> (&(unless is_nil(&1), do: Repo.preload(&1, :role))).()
		if is_nil(user) do
			false
		else
			user.role.permissions == permissions
		end
	end
	
	defp verify_user(user_data) do
		user = Repo.get_by(User, user_data)
		unless is_nil(user), do: user
	end

	defp hash_password_in_user_data(user_data) do
		user_data
		|> (&(put_in(&1, [:password_hash], Crypto.hash_string(&1[:password_hash])))).()
	end

	defp assign_basic_user_role(user_data) do
		user_data
		|> (&(put_in(&1, [:role_id], PermissionService.get_most_basic_role().id))).()
	end
end
