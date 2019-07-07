defmodule ElixirBackendSampleWeb.GraphQL.Types.Content_Type do
  use Absinthe.Schema.Notation
  import ElixirBackendSampleWeb.GraphQL.Other.Error_Handler
  alias ElixirBackendSampleWeb.Resolvers

  object :content do
    field(:id, :id)
    field(:user_id, :id)
    field(:text, :string)
  end

  object :content_queries do
    @desc "Get content"
    field :get_content, type: :content do
      arg(:id, non_null(:string))

      resolve(handle_errors(&Resolvers.Content_Resolver.get_content/3))
    end

    @desc "Get all user content"
    field :get_all_user_content, type: Absinthe.Schema.Notation.list_of(:content) do
      resolve(handle_errors(&Resolvers.Content_Resolver.get_user_content/3))
    end
  end

  object :content_mutations do
    @desc "Create content"
    field :create_content, type: :content do
      arg(:text, non_null(:string))

      resolve(handle_errors(&Resolvers.Content_Resolver.create_content/3))
    end
  end
end
