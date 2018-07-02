defmodule ElixirBackendSampleWeb.UserResolverTest do
  use ElixirBackendSampleWeb.ConnCase
  use Bamboo.Test
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
            resetUserPassword(email:"e.hansen31@live.com")
        }
      """

      res =
        context.conn
        |> put_req_header("content-type", "text")
        |> post("/api", query_reset_password)

      IO.inspect(res.resp_body)
      assert json_response(res, 200)["data"]["resetUserPassword"]

      # assert_delivered_email MyApp.Email.welcome_email(user)
      user = %{email: "e.hansen31@live.com"}
      email = ElixirBackendSampleWeb.Email.password_reset_email(user, "password")

      email |> ElixirBackendSample.Mailer.deliver_now

      # Works with deliver_now and deliver_later
      assert_delivered_email email
    end
  end

  test "update user with new password", context do
    {:ok, res} = registerUser(context)

    query_login = """
      query login{
        login(email:"e.hansen31@live.com", password:"password")
      }
      """

    login_res =
      context.conn
      |> put_req_header("content-type", "text")
      |> post("/api", query_login)

    case Poison.decode(login_res.resp_body, keys: :atoms) do
      {:ok, token_data} -> token = token_data.data.login
    end

    query = """
        mutation updateUser{
          updateUser(password: "password"){
            id
          }
        }
      """

    res =
      context.conn
      |> put_req_header("content-type", "text")
      |> put_req_header("authorization", token)
      |> post("/api", query)

      IO.inspect(res.resp_body)
      assert json_response(res, 200)["data"]["updateUser"]
  end
end
