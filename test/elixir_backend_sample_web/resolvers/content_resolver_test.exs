defmodule ElixirBackendSampleWeb.ContentResolverTest do
    use ElixirBackendSampleWeb.ConnCase
    use Bamboo.Test
    # alias ElixirBackendSampleWeb.Models.User
    require Logger

    describe "Content Resolver" do
        test "create a new user", context do
            # {:ok, note} = Notes.create_note(@user)

            query = """
            mutation {
                createContent(email:"e.hansen31@live.com", password:"password"){
                id
              }
            }
            """

            res =
              context.conn
              |> put_req_header("content-type", "text")
              |> post("/api", query)

            IO.inspect(res.resp_body)

            assert json_response(res, 200)["data"]["createUser"]["id"]
          end


    end
end