defmodule ElixirBackendSampleWeb.Schema.ContentTypes do
  use Absinthe.Schema.Notation

  scalar :json, name: "Json" do
    description("""
    The `Json` scalar type represents arbitrary json string data, represented as UTF-8
    character sequences. The Json type is most often used to represent a free-form
    human-readable json string.
    """)
    serialize(&encode/1)
    parse(&decode/1)
  end

  @spec decode(Absinthe.Blueprint.Input.String.t) :: {:ok, :string} | :error
  @spec decode(Absinthe.Blueprint.Input.Null.t) :: {:ok, nil}
  defp decode(%Absinthe.Blueprint.Input.String{value: value}) do
    case Poison.decode(value) do
      {:ok, result} -> {:ok, result}
      _ -> :error
    end
  end

  defp decode(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp decode(_) do
    :error
  end

  defp encode(value), do: value


  object :user do
    field(:id, :id)
    field(:email, :string)
    field(:password, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    field(:client_store, :json)
  end

  object :content do
    field(:id, :id)
    # need id to user here?
    field(:type, :string)
    field(:text, :string)
    field(:image, :string)
  end

end
