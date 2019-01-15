defmodule ElixirBackendSampleWeb.Models.Content do
    import Ecto.Changeset
    import Ecto.Query

    alias ElixirBackendSample.Repo
    alias ElixirBackendSampleWeb.EctoSchema.Content

    def create_content(user, text) do

        content = Ecto.build_assoc(user, :content, text: "Excellent!")
        changeset = Content.changeset(%Content{}, content)

        case Repo.insert(changeset) do
            {:error, changeset} -> {:error, changeset}
            {:ok, contentObj} -> {:ok, contentObj}
        end
    end

    def get_content(id) do
        query =
        from(
            c in ElixirBackendSampleWeb.Models.Content,
            where: c.id == ^id
        )

        Repo.one(query)
    end

    def get_user_content(id) do
        query = from(
            c in ElixirBackendSampleWeb.Models.Content,
            where: c.user_id == ^id
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