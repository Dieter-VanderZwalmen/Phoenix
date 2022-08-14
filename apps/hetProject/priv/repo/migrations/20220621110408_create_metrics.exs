defmodule HetProject.Repo.Migrations.CreateMetrics do
  use Ecto.Migration

  def change do
    create table(:metrics) do
      add :pad, :string
      add :aantal_bezoek, :integer
      add :type, :string
      add :user_id, references(:users,on_delete: :delete_all), null: true

      timestamps()
    end
  end
end
