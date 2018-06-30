defmodule ElixirBackendSampleWeb.UserResolverTest do
    use ElixirBackendSampleWeb.ConnCase
    # alias ElixirBackendSampleWeb.Models.User
    require Logger
    @user %{email: "some body", password: true, faved: true, title: "some title"}

    describe "User Resolver" do
      test "create a new user", context do
        # {:ok, note} = Notes.create_note(@user)

        query = """
        mutation createUser{
            createUser(email:"e.hansen31@live.com", password:"password"){
            id
          }
        }
        """

        res = context.conn
            |> put_req_header("content-type", "text")
            |> post("/api", query)
        
        IO.inspect res.resp_body

        assert json_response(res, 200)["data"]["createUser"]["id"]
      end

      test "user login", context do
        query_one = """
        mutation createUser{
            createUser(email:"e.hansen31@live.com", password:"password"){
            id
          }
        }
        """

        res = context.conn
            |> put_req_header("content-type", "text")
            |> post("/api", query_one)

        query = """
        query login{
          login(email:"e.hansen31@live.com", password:"password")
        }
        """

        res = context.conn
            |> put_req_header("content-type", "text")
            |> post("/api", query)

        IO.inspect res.resp_body

        assert json_response(res, 200)["data"]["login"]

      end

      

    end
  end