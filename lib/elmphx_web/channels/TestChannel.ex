defmodule Elmphx.TestChannel do
  use ElmphxWeb, :channel
  alias Elmphx.Repo

  def join("room", _params, socket) do
    usersDB = Repo.all(Elmphx.Accounts.Users)
    IO.puts "=================+"
    IO.inspect usersDB
    IO.puts "=================+"
    {:ok, %{users: usersDB}, socket}
  end

  def handle_in(params, _params2, socket) do

    {:reply, :ok, socket}
  end

end
