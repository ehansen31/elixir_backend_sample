defmodule ElixirBackendSampleWeb.Models.Content do
    import Ecto.Changeset
    import Ecto.Query
    require Logger
    alias ElixirBackendSample.Repo
    alias ElixirBackendSampleWeb.EctoSchema.Content
    alias ElixirBackendSampleWeb.Schema.ContentTypes

    @spec create_content(%{__struct__: atom}, any) :: {:error, any} | {:ok, any}
    def create_content(user, text) do
        content = Ecto.build_assoc(user, :content, text: text)

        case Repo.insert(content) do
            {:error, changeset} -> {:error, changeset}
            {:ok, contentObj} ->
                Logger.warn "content creation result"
                IO.inspect(contentObj)
                {:ok, contentObj}
        end
        # val
    end

    def get_content(userObj, id) do
        query =
        from c in ElixirBackendSampleWeb.EctoSchema.Content,
        where: c.id == ^id

        data = Repo.one(query)
        Logger.warn "get content query is: #{inspect(data)}"
        # check that the content belongs to the authenticated user
        {:ok, data}
        # case Repo.all(query) do
        #     {:ok, data} -> data
        #     {:error, reason} -> {:error, reason}
        #     _->{:error,"content not found"}
        # end
    end

    def get_user_content(id) do
        Logger.warn "made it to model"
        query = from(
            c in ElixirBackendSampleWeb.EctoSchema.Content,
            where: c.user_id == ^id,
            preload: [:user]
        )

        Logger.warn "get all user content query is: "
        IO.inspect query

        data = Repo.all(query)
        Logger.warn "get all user content data is: "
        IO.inspect data
    end

    def update_content(content, args) do
        updated_content = Ecto.Changeset.change(content, args)

        case Repo.update updated_content do
          {:error, changeset} -> {:error, changeset}
          {:ok, changeset} -> {:ok, changeset}
        end
    end
end
