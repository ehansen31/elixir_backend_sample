defmodule ElixirBackendSampleWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  object :post do
    field(:id, :id)
    field(:title, :string)
    field(:body, :string)
  end

  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:password, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
  end
end
