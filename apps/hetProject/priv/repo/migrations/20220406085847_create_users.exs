defmodule HetProject.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false
      add :gender, :string, null: false
      add :role, :string, null: false
      add :hashed_password, :string, null: false
      

      timestamps()
    end
  end
end
