defmodule HetProject.ApiKeyContext.ApiKeys do
  use Ecto.Schema
  import Ecto.Changeset
  alias HetProject.UserContext.User

  schema "api_keys" do
    field :api_key, :string

    belongs_to :user, User #I'm new!
    timestamps()
  end



  @doc false
  def changeset(api, attrs,user) do
    
    api
    |> cast(attrs, [:api_key])
    |> validate_required([:api_key])
    |> put_assoc(:user, user)


  end
  def changeset2(api, attrs) do
    api
    |> cast(attrs, [:api_key])
    |> validate_required([:api_key])
  end



  # defp add_key(changeset2) do
  #   case changeset2 do
  #     %Ecto.Changeset{valid?: true} ->
  #       put_change(changeset2, :api_key, generate_key(32))
  #       _->
  #       changeset2
  #   end
  #  end

end
