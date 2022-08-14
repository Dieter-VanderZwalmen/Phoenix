defmodule HetProject.Repo.Migrations.CreatePrograms do
  use Ecto.Migration

  def change do
    create table(:programs) do
      add :name, :string
      add :author, :string
      add :details, :string
      add :duration, :integer
      add :difficulty, :string
      add :type, :string




      timestamps()
    end
  end
end
