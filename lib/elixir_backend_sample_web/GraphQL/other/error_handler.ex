defmodule ElixirBackendSampleWeb.GraphQL.Other.Error_Handler do
  @spec format_changeset(atom | %{errors: any}) :: {:error, [any]}
  defp format_changeset(changeset) do
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
end
