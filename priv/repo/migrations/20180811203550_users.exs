defmodule ElixirBackendSample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    # drop table(:users)
    # drop table(:content)

    create table(:users) do
      # add(:id, :id)
      add(:email, :string)
      add(:password_hash, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:age, :integer)
      add(:client_store, :map, default: "{}")
      timestamps()
    end

    create table(:content) do
      # add(:id, :id)
      add :user_id, references(:users)
      add :text, :string
      timestamps()
    end

    create(unique_index(:users, [:email]))
  end
end
