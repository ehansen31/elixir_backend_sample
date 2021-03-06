defmodule ElixirBackendSampleWeb.ContentResolverTest do
  use ElixirBackendSampleWeb.ConnCase
  use Bamboo.Test
  # alias ElixirBackendSampleWeb.Models.User
  use ExUnit.Case, async: false
  alias ElixirBackendSampleWeb.TestHelper
  require Logger

  describe "Content Resolver" do
    test "create content on an existing user", context do
      {:ok, token} = TestHelper.register_login_getToken()

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

      assert json_response(res, 200)["data"]["createContent"]["id"]
    end

    test "get content from specific id", context do
      {:ok, token} = TestHelper.register_login_getToken()

      {:ok, content_id} = TestHelper.create_content_return_id(token)

      query = """
          query{
              getContent(id:"#{to_string(content_id)}"){
                  text
              }
          }
      """

      res =
        build_conn()
        |> put_req_header("content-type", "text")
        |> put_req_header("authorization", token)
        |> post("/api", query)

      assert json_response(res, 200)["data"]["getContent"]["text"]
    end

    test "get all content for a user", context do
      {:ok, token} = TestHelper.register_login_getToken()

      TestHelper.create_content_return_id(token)
      TestHelper.create_content_return_id(token)
      TestHelper.create_content_return_id(token)

        query = """
            query{
                getAllUserContent{
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

        assert length(json_response(res, 200)["data"]["getAllUserContent"]) == 3
    end
  end
end
