defmodule ElixirBackendSample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    drop(table(:users))

    create table(:users) do
      add(:email, :string)
      add(:password_hash, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:age, :integer)
    end

    create(unique_index(:users, [:email]))
  end
end
