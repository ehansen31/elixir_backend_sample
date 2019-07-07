defmodule ElixirBackendSampleWeb.GraphQL.Types.User_Type do
  use Absinthe.Schema.Notation
  import ElixirBackendSampleWeb.GraphQL.Other.Error_Handler
  alias ElixirBackendSampleWeb.Resolvers

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:password, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    field(:client_store, :json)
  end

  object :user_queries do
    @desc "Get user by id"
    field :get_user_by_id, :integer do
      arg(:id, non_null(:integer))

      resolve(handle_errors(&Resolvers.User_Resolver.login/3))
    end

    @desc "Get user"
    field :get_user, :user do
      resolve(&Resolvers.User_Resolver.get_user/3)
    end

    @desc "Login and return token"
    field :login, :string do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))

      resolve(handle_errors(&Resolvers.User_Resolver.login/3))
    end

    @desc "Is the user logged in"
    field :is_logged, :boolean do
      resolve(handle_errors(&Resolvers.User_Resolver.is_logged/3))
    end
  end

  object :user_mutations do
    @desc "Create a user"
    field :create_user, type: :user do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      arg(:first_name, :string)
      arg(:last_name, :string)
      arg(:age, :integer)

      resolve(handle_errors(&Resolvers.User_Resolver.create_user/3))
    end

    @desc "Update user"
    field :update_user, type: :user do
      arg(:email, :string)
      arg(:password, :string)
      arg(:first_name, :string)
      arg(:last_name, :string)
      arg(:age, :integer)
      arg(:client_store, :json)

      resolve(handle_errors(&Resolvers.User_Resolver.update_user/3))
    end

    @desc "Reset user password via email"
    field :reset_user_password, type: :string do
      arg(:email, non_null(:string))

      resolve(handle_errors(&Resolvers.User_Resolver.reset_password/3))
    end
  end
end
