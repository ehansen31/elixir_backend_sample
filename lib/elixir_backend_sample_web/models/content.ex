defmodule ElixirBackendSampleWeb.Models.Content do
    import Ecto.Changeset
    import Ecto.Query

    alias ElixirBackendSample.Repo
    alias ElixirBackendSampleWeb.EctoSchema.Content
    alias ElixirBackendSampleWeb.Schema.ContentTypes

    def create_content(user, text) do

        content = Ecto.build_assoc(user, :content, text: text)
        IO.inspect(content)
        # changeset = Content.changeset(%Content{}, content)

        case Repo.insert(content) do
            {:error, changeset} -> {:error, changeset}
            {:ok, contentObj} -> {:ok, contentObj}
        end
    end

    def get_content(userObj, id) do
        query =
        from(
            c in ElixirBackendSampleWeb.EctoSchema.Content,
            where: c.id == ^id,
            preload: [:user]
        )


        # case Repo.one(query) do
        #     {:ok, contentObj} -> {:ok, contentObj}
        #     _ -> {:error, "content not found"}
        # end
        Repo.one(query)

        # ensure that the content belongs to the user requesting it

        # Repo.one from content in ElixirBackendSampleWeb.EctoSchema.Content,
        #     where: content.id == ^id and user.id == ^userObj.id,
        #     preload: [:user]

        # assoc(current_user, :posts) |> Post.published() |> Repo.all()
    end

    def get_user_content(id) do
        query = from(
            c in ElixirBackendSampleWeb.EctoSchema.Content,
            where: c.user_id == ^id,
            preload: [:user]
        )

        Repo.all(query)
    end

    def update_content(content, args) do
        updated_content = Ecto.Changeset.change(content, args)

        case Repo.update updated_content do
          {:error, changeset} -> {:error, changeset}
          {:ok, changeset} -> {:ok, changeset}
        end
    end
end