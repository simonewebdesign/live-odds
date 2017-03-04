defmodule AccountTest do

  use ExUnit.Case
  alias LiveOdds.Account

  setup do
    {:ok, _} = Account.start_link(1)
    {:ok, _} = Account.start_link(2)
    {:ok, _} = Account.start_link(3)

    on_exit fn ->
      :ok = Account.stop(1)
      :ok = Account.stop(2)
      :ok = Account.stop(3)
    end

    :ok
  end


  test "ask for current balance" do
    assert 0 == Account.balance(1)
    assert 0 == Account.balance(2)
    assert 0 == Account.balance(3)
  end


  test "deposit" do
    assert :ok == Account.credit(1, 50)
    assert 50 == Account.balance(1)

    assert :ok == Account.credit(2, 70)
    assert 70 == Account.balance(2)
  end


  test "deposit and withdraw" do
    assert :ok == Account.credit(3, 100)
    assert :ok == Account.debit(3, 30)
    assert 70 == Account.balance(3)
  end


  test "depositing a negative amount should error" do
    {:error, msg} = Account.credit(3, -1)

    assert msg == "not a positive credit"
  end


  test "withdrawing more than the availability should error" do
    :ok = Account.credit(3, 50)
    {:error, msg} = Account.debit(3, 60)

    assert msg == "not enough money"
  end

end
