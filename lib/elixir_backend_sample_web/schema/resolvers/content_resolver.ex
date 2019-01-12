defmodule ElixirBackendSampleWeb.Resolvers.Content_Resolver do
  
  alias ElixirBackendSampleWeb.Models.Content
  alias ElixirBackendSample.Repo  

  def create_content(_parent, args, %{context: %{current_user: user}}) do
    Blog.Content.create_post(current_user, args)
  end

  def create_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end


  def get_content(_parent, args, %{context: %{current_user: user}}) do


    Blog.Content.create_post(current_user, args)
  end

  def get_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end


  def get_user_content(_parent, args, %{context: %{current_user: user}}) do
    Blog.Content.create_post(current_user, args)
  end

  def get_user_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end
