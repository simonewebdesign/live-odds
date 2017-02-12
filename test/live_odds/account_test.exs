defmodule AccountTest do

  use ExUnit.Case
  alias LiveOdds.Account


  # test "it works" do
  #   :ok = Account.start()
  #   assert 0 == Account.balance()
  #   :ok = Account.credit(50)
  #   assert 50 == Account.balance()
  #   :ok = Account.credit(100)
  #   :ok = Account.debit(30)
  #   assert 120 == Account.balance()
  #   :ok = Account.stop()
  # end

  setup do
    :ok = Account.start()
  end


  test "close an account" do
    :ok = Account.stop()
  end


  test "ask for current balance" do

  end


  test "credit" do

  end


  test "debit" do

  end

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
