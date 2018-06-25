defmodule ElixirBackendSample.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add(:email, :string)
      add(:password, :string)
      add(:first_name, :string)
      add(:last_name, :string)
      add(:age, :integer)
      create unique_index(:users, [:email])
    end
  end
end
