defmodule ElixirBackendSampleWeb.Schema do
  use Absinthe.Schema
  import_types(ElixirBackendSampleWeb.Schema.ContentTypes)

  alias ElixirBackendSampleWeb.Resolvers

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

        resolve(&Resolvers.User.create_user/3)
      end
    end
  end
end
