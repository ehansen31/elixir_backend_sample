defmodule ElixirBackendSampleWeb.ContentResolverTest do
    use ElixirBackendSampleWeb.ConnCase
    use Bamboo.Test
    # alias ElixirBackendSampleWeb.Models.User
    alias ElixirBackendSampleWeb.TestHelper
    require Logger

    describe "Content Resolver" do
        test "create content on an existing user", context do
            # {:ok, note} = Notes.create_note(@user)
            {:ok, token} = TestHelper.register_login_getToken(context)


            res =
              context.conn
              |> put_req_header("content-type", "text")
              |> post("/api", query)
              |> put_req_header("authorization", token)

            IO.inspect(res.resp_body)

            assert json_response(res, 200)["data"]["createContent"]["id"]
          end


    end
end