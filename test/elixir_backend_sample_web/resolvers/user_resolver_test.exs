defmodule ElixirBackendSampleWeb.UserResolverTest do
  use ElixirBackendSampleWeb.ConnCase
  # alias ElixirBackendSampleWeb.Models.User
  require Logger
  @user %{email: "some body", password: true, faved: true, title: "some title"}

  defp registerUser(context) do
    query_register_user = """
      mutation createUser{
          createUser(email:"e.hansen31@live.com", password:"password"){
          id
        }
      }
    """

    res =
      context.conn
      |> put_req_header("content-type", "text")
      |> post("/api", query_register_user)

    {:ok, res}
  end

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

      res =
        context.conn
        |> put_req_header("content-type", "text")
        |> post("/api", query)

      IO.inspect(res.resp_body)

      assert json_response(res, 200)["data"]["createUser"]["id"]
    end

    test "user login", context do
      {:ok, res} = registerUser(context)

      query = """
      query login{
        login(email:"e.hansen31@live.com", password:"password")
      }
      """

      res =
        context.conn
        |> put_req_header("content-type", "text")
        |> post("/api", query)

      IO.inspect(res.resp_body)

      assert json_response(res, 200)["data"]["login"]
    end

    test "reset password with registered email", context do
      {:ok, res} = registerUser(context)

      query_reset_password = """
        mutation resetUserPassword{
            resetUserPassword(email:"e.hansen31@live.com"){
              
            }
        }          
      """

      res =
        context.conn
        |> put_req_header("content-type", "text")
        |> post("/api", query_reset_password)

      IO.inspect(res.resp_body)
      assert json_response(res, 200)

      # assert_delivered_email MyApp.Email.welcome_email(user)
    end
  end
end
