ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(ElixirBackendSample.Repo, {:shared, self()})

defmodule ElixirBackendSampleWeb.TestHelper do
  use ElixirBackendSampleWeb.ConnCase

  require Logger

  def register_login_getToken() do
    query_register_user = """
        mutation{
            createUser(email:"e.hansen31@live.com", password:"password"){
                id
            }
        }
    """

    res =
      build_conn()
      |> put_req_header("content-type", "text")
      |> post("/api", query_register_user)

    query_login = """
        query login{
            login(email:"e.hansen31@live.com", password:"password")
        }
    """

    token =
      build_conn()
      |> put_req_header("content-type", "text")
      |> post("/api", query_login)
      |> (fn login_res ->
            case Poison.decode(login_res.resp_body, keys: :atoms) do
              {:ok, token_data} -> token_data.data.login
            end
          end).()

    {:ok, token}
  end

  def create_content_return_id(user_token) do
    mutation_create_content = """
    mutation{
        createContent(text:"example text here"){
            id,
            text
        }
    }
    """

    content_id =
      build_conn()
      |> put_req_header("content-type", "text")
      |> put_req_header("authorization", user_token)
      |> post("/api", mutation_create_content)
      |> (fn create_content_res ->
            case Poison.decode(create_content_res.resp_body, keys: :atoms) do
              {:ok, content_data} -> content_data.data.createContent.id
            end
          end).()

    {:ok, content_id}
  end
end
