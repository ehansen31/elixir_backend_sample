ExUnit.start()

Ecto.Adapters.SQL.Sandbox.mode(ElixirBackendSample.Repo, :manual)

defmodule ElixirBackendSampleWeb.TestHelper do
    def register_login_getToken(context)do
        query_register_user = """
            mutation{
                createUser(email:"e.hansen31@live.com", password:"password"){
                    id
                }
            }
        """

        res =
            context.conn
            |> put_req_header("content-type", "text")
            |> post("/api", query_register_user)

        query_login = """
            query login{
                login(email:"e.hansen31@live.com", password:"password")
            }
        """

        token =
            context.conn
            |> put_req_header("content-type", "text")
            |> post("/api", query_login)
            |> (fn login_res ->
            case Poison.decode(login_res.resp_body, keys: :atoms) do
                {:ok, token_data} -> token_data.data.login
            end
            end).()

        {:ok, token}
    end
end