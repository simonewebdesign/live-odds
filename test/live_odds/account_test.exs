defmodule AccountTest do

  use ExUnit.Case
  alias LiveOdds.Account


  setup do
    :ok = Account.start()

    on_exit(fn() ->
      :ok = Account.stop()
    end)
  end


  test "ask for current balance" do
    assert 0 == Account.balance()
  end


  test "deposit" do
    assert :ok == Account.credit(50)
    assert 50 == Account.balance()
  end


  test "deposit and withdraw" do
    assert :ok == Account.credit(100)
    assert :ok == Account.debit(30)
    assert 70 == Account.balance()
  end


  test "depositing a negative amount should error" do
    {:error, msg} = Account.credit(-1)

    assert msg == "not a positive credit"
  end


  test "withdrawing more than the availability should error" do
    :ok = Account.credit(50)
    {:error, msg} = Account.debit(60)

    assert msg == "not enough money"
  end

end
