defmodule HetProject.Repo.Migrations.CreateUserApiKey do
  use Ecto.Migration

  def change do
    create table(:api_keys) do
      add :user_id, references(:users,on_delete: :delete_all)
      add :api_key, :string

      timestamps()
    end

    create unique_index(:api_keys, [:user_id], on_delete: :delete_all)
  end
end
