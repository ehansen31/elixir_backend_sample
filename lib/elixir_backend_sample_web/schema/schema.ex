defmodule ElixirBackendSampleWeb.Schema do
  use Absinthe.Schema
  import_types(ElixirBackendSampleWeb.Schema.ContentTypes)

  alias ElixirBackendSampleWeb.Resolvers

  use Ecto.Schema
  import Ecto.Changeset

  def format_changeset(changeset) do
    errors =
      changeset.errors
      |> Enum.map(fn {key, {value, context}} ->
        [message: "#{key} #{value}", details: context]
      end)

    {:error, errors}
  end

  def handle_errors(fun) do
    fn source, args, info ->
      case Absinthe.Resolution.call(fun, source, args, info) do
        {:error, %Ecto.Changeset{} = changeset} -> format_changeset(changeset)
        val -> val
      end
    end
  end

  object :user_object do
    query do
        @desc "Get user by id"
        field :get_user_by_id, :integer do
          arg(:id, non_null(:integer))

          resolve(&Resolvers.User_Resolver.login/3)
        end

        @desc "Get user"
        field :get_user, :user do
          resolve(&Resolvers.User_Resolver.get_user/3)
        end

        @desc "Login and return token"
        field :login, :string do
          arg(:email, non_null(:string))
          arg(:password, non_null(:string))

          resolve(&Resolvers.User_Resolver.login/3)
        end

        @desc "Is the user logged in"
        field :is_logged, :boolean do
          resolve(&Resolvers.User_Resolver.is_logged/3)
        end
      end

    mutation do
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

  object :content_object do
    query do
      @desc "Get content"
      field :get_content, type: :content do
        arg(:id, non_null(:integer))

        resolve(handle_errors(&Resolvers.Content_Resolver.get_content/3))
      end

      @desc "Get User Content"
      field :get_content, type: :content do
        arg(:id, non_null(:integer))

        resolve(handle_errors(&Resolvers.Content_Resolver.get_user_content/3))
      end
    end

    mutation do
      @desc "Create content"
      field :create_content, type: :content do
        arg(:text, non_null(:string))

        resolve(handle_errors(&Resolvers.Content_Resolver.create_content/3))
    end
  end
end
