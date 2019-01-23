defmodule ElixirBackendSampleWeb.Resolvers.Content_Resolver do

  alias ElixirBackendSampleWeb.Models.Content
  alias ElixirBackendSample.Repo

  import Logger

  def create_content(_parent, args, %{context: %{current_user: current_user}}) do
    Content.create_content(current_user, args.text)
  end

  def create_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end


  def get_content(_parent, args, %{context: %{current_user: current_user}}) do

    Content.get_content(current_user, args.id)
  end

  def get_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end


  def get_user_content(_parent, args, %{context: %{current_user: current_user}}) do
    Content.get_user_content(current_user.id)
  end

  def get_user_content(_parent, _args, _resolution) do
    {:error, "Access denied"}
  end
end