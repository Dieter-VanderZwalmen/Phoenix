defmodule HetProject.Repo.Migrations.CreateUserProgram do
  use Ecto.Migration

  def change do
    create table(:user_programs) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :program_id, references(:programs, on_delete: :delete_all)
      add :completed, :boolean, default: false, null: false
    end

    create unique_index(:user_programs, [:user_id, :program_id],on_delete: :delete_all)
  end
end
