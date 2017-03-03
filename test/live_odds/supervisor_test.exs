defmodule SupervisorTest do

  use ExUnit.Case

  setup do
    {:ok, pid} = LiveOdds.Supervisor.start_link()
    {:ok, [pid: pid]}
  end

  test "it's alive!", %{pid: pid} do
    assert Process.alive?(pid)
  end

  test "starts Account and PubSub", %{pid: pid} do
    [{PubSub, _, _, _},
     {LiveOdds.Account, _, _, _},
    ] = Supervisor.which_children(pid)
  end

end
