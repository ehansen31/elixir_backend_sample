defmodule ElixirBackendSampleWeb.Models.Content do
    import Ecto.Changeset
    import Ecto.Query
    require Logger
    alias ElixirBackendSample.Repo
    alias ElixirBackendSampleWeb.EctoSchema.Content
    alias ElixirBackendSampleWeb.Schema.ContentTypes

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
        from(
            c in ElixirBackendSampleWeb.EctoSchema.Content,
            # where: c.id == ^id,
            # preload: [:user]
        )
        # Logger.warn "get content query is: "
        # IO.inspect query
        # case Repo.get(ElixirBackendSampleWeb.EctoSchema.Content, id) do
        #     {:ok, contentObj} -> {:ok, contentObj}
        #     {:error, reason} -> {:error, reason}
        #     _ -> {:error, "content not found"}            
        # end
        case Repo.one(query) do
            {:ok, contentObj} -> {:ok, contentObj}
            {:error, reason} -> {:error, reason}
            _ -> {:error, "content not found"}
        end

        # val = Repo.one(query)
        # Logger.warn "inspect get content query contents: "<>val
        # {:ok, val}
 
        # ensure that the content belongs to the user requesting it

        # Repo.one from content in ElixirBackendSampleWeb.EctoSchema.Content,
        #     where: content.id == ^id and user.id == ^userObj.id,
        #     preload: [:user]

        # assoc(current_user, :posts) |> Post.published() |> Repo.all()
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