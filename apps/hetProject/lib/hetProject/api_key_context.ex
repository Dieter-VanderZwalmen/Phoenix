defmodule HetProject.ApiKeyContext do
  import Ecto.Query, only: [from: 2]
  import Ecto.Query, warn: false
  alias HetProject.Repo

  alias HetProject.UserContext.User
  alias HetProject.ApiKeyContext.ApiKeys
 def create_api_key(_attrs,%User{} = user) do

  %ApiKeys{}
  |> ApiKeys.changeset(%{:api_key => generate_key(32)},user)
  |> Repo.insert()

  end


def delete_api_key(_attrs,%ApiKeys{} = apiKey) do
    Repo.delete(apiKey)
end
def change_api(%ApiKeys{} = api) do
  ApiKeys.changeset2(api, %{})
end


defp generate_key(length)do
  :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
end
def list_apis() do

  Repo.all(ApiKeys)
end

end
