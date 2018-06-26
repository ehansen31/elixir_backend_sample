defmodule ElixirBackendSampleWeb.Schema do
  use Absinthe.Schema
  import_types(ElixirBackendSampleWeb.Schema.ContentTypes)

  alias ElixirBackendSampleWeb.Resolvers

  use Ecto.Schema
  import Ecto.Changeset

  def format_changeset(changeset) do
    # {:error, [email: {"has already been taken", []}]}
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

  query do
    @desc "Get all posts"
    field :posts, list_of(:post) do
      resolve(&Resolvers.Content.list_posts/3)
    end

    mutation do
      @desc "Create a user"
      field :create_user, type: :post do
        arg(:email, non_null(:string))
        arg(:password, non_null(:string))
        arg(:first_name, :string)
        arg(:last_name, :string)
        arg(:age, :integer)

        resolve handle_errors(&Resolvers.User.create_user/3)
      end
    end
  end
end
