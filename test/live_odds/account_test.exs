defmodule AccountTest do

  use ExUnit.Case
  alias LiveOdds.Account


  setup do
    :ok = Account.start()
  end

  # test "open an account" do
    # assert :ok == Account.start()
  # end


  test "ask for current balance" do
    # assert :ok == Account.start()
    assert 0 == Account.balance()
  end


  test "credit" do
    # {:ok, pid} = Account.start()
    # msg = {:credit, 50}
    # send(pid, {msg, self()})

    # assert_receive(:ok)
    # assert :ok == Account.start()
    assert :ok == Account.credit(50)
  end


  test "debit" do
    assert :ok == Account.credit(100)
    assert :ok == Account.debit(30)
    assert 70 == Account.balance()
  end

  # test "close an account" do
  #   assert :ok == Account.stop()
  # end


  # test "deposit and then withdraw" do
  #   {:ok, pid} = Account.start()
  #   msg1 = {:credit, 50}
  #   msg2 = {:debit, 30}
  #   send(pid, {msg1, self()})
  #   send(pid, {msg2, self()})

  #   assert_receive(:ok)
  #   assert_receive(:ok)
  # end


  # test "depositing a negative amount should error" do
  #   {:ok, pid} = Account.start()
  #   msg = {:credit, -1}
  #   send(pid, {msg, self()})

  #   assert_receive({:error, "not a positive credit"})
  # end


  # test "withdrawing more than the availability should error" do
  #   {:ok, pid} = Account.start()
  #   msg1 = {:credit, 50}
  #   msg2 = {:debit, 60}
  #   send(pid, {msg1, self()})
  #   send(pid, {msg2, self()})

  #   assert_receive(:ok)
  #   assert_receive({:error, "not enough money"})
  # end

end
