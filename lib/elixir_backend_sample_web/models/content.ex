defmodule ElixirBackendSampleWeb.Models.Content do
  import Ecto.Changeset
  import Ecto.Query
  require Logger
  alias ElixirBackendSample.Repo
  alias ElixirBackendSampleWeb.EctoSchema.Content
  alias ElixirBackendSampleWeb.GraphQL.Objects.ContentTypes

  @spec create_content(%{__struct__: atom}, any) :: {:error, any} | {:ok, any}
  def create_content(user, text) do
    content = Ecto.build_assoc(user, :content, text: text)

    case Repo.insert(content) do
      {:error, changeset} ->
        {:error, changeset}

      {:ok, contentObj} ->
        {:ok, contentObj}
    end

    # val
  end

  def get_content(userObj, id) do
    query =
      from(c in ElixirBackendSampleWeb.EctoSchema.Content,
        join: user in assoc(c, :user),
        where: c.id == ^id and user.id == ^userObj.id,
        preload: [user: user]
      )

    data = Repo.one(query)
    {:ok, data}
  end

  def get_user_content(id) do
    query =
      from(c in ElixirBackendSampleWeb.EctoSchema.Content,
        join: user in assoc(c, :user),
        where: user.id == ^id,
        preload: [user: user]
      )

    data = Repo.all(query)
    {:ok, data}
  end

  def update_content(content, args) do
    updated_content = Ecto.Changeset.change(content, args)

    case Repo.update(updated_content) do
      {:error, changeset} -> {:error, changeset}
      {:ok, changeset} -> {:ok, changeset}
    end
  end
end
