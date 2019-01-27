defmodule ElixirBackendSampleWeb.ContentResolverTest do
    use ElixirBackendSampleWeb.ConnCase
    use Bamboo.Test
    # alias ElixirBackendSampleWeb.Models.User
    alias ElixirBackendSampleWeb.TestHelper
    require Logger

    describe "Content Resolver" do
        test "create content on an existing user", context do
            {:ok, token} = TestHelper.register_login_getToken()

            Logger.warn token

            query = """
                mutation{
                    createContent(text:"example text here"){
                        id,
                        text
                    }
                }
            """

            res =
            build_conn()
              |> put_req_header("content-type", "text")
              |> put_req_header("authorization", token)
              |> post("/api", query)

            IO.inspect(res.resp_body)

            assert json_response(res, 200)["data"]["createContent"]["id"]
        end

        test "get content from specific id", context do
            {:ok, token} = TestHelper.register_login_getToken()

            query = """
                query{
                    getContent(id:1){
                        id,
                        text
                    }
                }
            """

            res =
            build_conn()
              |> put_req_header("content-type", "text")
              |> put_req_header("authorization", token)
              |> post("/api", query)

            IO.inspect(res.resp_body)

            assert json_response(res, 200)["data"]["createContent"]["id"]
        end
    end
end