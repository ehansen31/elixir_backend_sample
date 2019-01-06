defmodule ElixirBackendSampleWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation  

  scalar :json do
    parse fn input ->
      case Poison.decode(input.value) do
        {:ok, result} -> (
          ElixirBackendSample.Logger.info "decoded input value: #{result}"
          result
        )
        _ -> (
          ElixirBackendSample.Logger.info "decoded input value error: #{input}"
          :error
        )
      end
    end
  
    serialize &Poison.encode!/1
  end

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
    field(:client_store, :json)
  end
end
