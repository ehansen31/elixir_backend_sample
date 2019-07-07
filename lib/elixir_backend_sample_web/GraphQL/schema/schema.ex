defmodule ElixirBackendSampleWeb.GraphQL.Schema.Schema do
  use Absinthe.Schema
  import_types(ElixirBackendSampleWeb.GraphQL.Other.JSON_Scalar_Type)
  import_types(ElixirBackendSampleWeb.GraphQL.Types.User_Type)
  import_types(ElixirBackendSampleWeb.GraphQL.Types.Content_Type)

  query do
    import_fields(:user_queries)
    import_fields(:content_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:content_mutations)
  end
end
