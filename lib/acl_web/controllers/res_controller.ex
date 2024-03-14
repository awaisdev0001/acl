defmodule AclWeb.ResController do
  @moduledoc false

  alias Acl.Acl_context
  alias Acl.Acl_context.Res

  def index(conn, _params) do
    acl_res = Acl_context.list_acl_res()
    Enum.map(acl_res, fn res -> %{res: res.res, parent: res.parent} end)
  end

  def create(res_params) do
    Acl_context.create_res(res_params)
    with {:ok, %Res{} = res} <- Acl_context.create_res(res_params) do
      %{res: res.res, parent: res.parent}
    end

  end

  def show(conn, %{"id" => id}) do
    res = Acl_context.get_res!(id)
    if res do
      %{res: res.res, parent: res.parent}
    end
  end

  def update(conn, %{"id" => id, "res" => res_params}) do
    res = Acl_context.get_res!(id)

    with {:ok, %Res{} = res} <- Acl_context.update_res(res, res_params) do
      %{res: res.res, parent: res.parent}
    end
  end

  def delete(conn, %{"id" => id}) do
    res = Acl_context.get_res!(id)

    with {:ok, %Res{} = res} <- Acl_context.delete_res(res) do
      {:ok, %{res: res.res, parent: res.parent}}
    end
  end
end
