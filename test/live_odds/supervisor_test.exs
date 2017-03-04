defmodule SupervisorTest do

  use ExUnit.Case

  setup do
    {:ok, pid} = LiveOdds.Supervisor.start_link()
    {:ok, [pid: pid]}
  end

  test "it's alive!", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "starts 3 Accounts and PubSub", %{pid: pid} do
    [{PubSub, _, _, _},
     {_, _, _, [LiveOdds.Account]},
     {_, _, _, [LiveOdds.Account]},
     {_, _, _, [LiveOdds.Account]},
    ] = Supervisor.which_children(pid)
  end

end
