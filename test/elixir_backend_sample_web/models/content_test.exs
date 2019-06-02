defmodule ElixirBackendSampleWeb.ContentTest do
    use ExUnit.Case#, async: true
    alias ElixirBackendSampleWeb.Models.Content
    alias ElixirBackendSampleWeb.Models.User
    require Logger

    # setup_all do
    #     IO.puts "Setting up content unit tests"
    
    #     # create a user here.
        

    #     :ok
    #   end

    describe "Content Model" do
        test "creating content", context do
            user = User.get_user("1")
            content = Content.create_content(user, "test content creation here")
            Logger.warn "content object is: #{inspect(content)}"
            assert content
        end

        # test "getting content by id" do

        # end

        # test "getting all content for a user" do

        # end
    end
end