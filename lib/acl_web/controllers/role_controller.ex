defmodule AclWeb.RoleController do
  @moduledoc false

  alias Acl.Acl_context
  alias Acl.Acl_context.Role

  def index(conn, _params) do
    acl_roles = Acl_context.list_acl_roles()
    Enum.map(acl_roles, fn role -> %{id: role.id, role: role.role} end)
  end

  def create( role_params) do
    Acl_context.create_role(role_params)
    with {:ok, %Role{} = role} <- Acl_context.create_rule(role_params) do
      %{id: role.id, role: role.role}
    end
  end

  def show(conn, %{"id" => id}) do
    role = Acl_context.get_role!(id)
    if role do
      %{id: role.id, role: role.role}
    end
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Acl_context.get_role!(id)

    with {:ok, %Role{} = role} <- Acl_context.update_role(role, role_params) do
      %{id: role.id, role: role.role}
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Acl_context.get_role!(id)

    with {:ok, %Role{} = role} <- Acl_context.delete_role(role) do
      {:ok,  %{id: role.id, role: role.role}}
    end
  end
end
