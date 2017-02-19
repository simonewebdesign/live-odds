defmodule LiveOdds.Account do
  @moduledoc """
  A bank account.
  """


  @doc "Open a bank account."
  @spec start() :: {:ok, pid} | {:error, {:already_started, pid} | term}
  def start do
    Agent.start(fn -> 0 end, [name: :account])
  end


  @doc "Close a bank account."
  @spec stop() :: :ok
  def stop do
    Agent.stop(:account)
  end


  @doc "Returns the current account balance."
  @spec balance() :: integer
  def balance do
    Agent.get(:account, & &1)
  end


  @doc "Deposit money."
  @spec credit(pos_integer) :: :ok | :error
  def credit(amount) do
    if amount > 0 do
      Agent.update(:account, & &1 + amount)
    else
      {:error, "not a positive credit"}
    end
  end


  @doc "Withdraw money."
  @spec debit(pos_integer) :: :ok | :error
  def debit(amount) do
    Agent.get_and_update(:account, fn(balance) ->
      case amount > balance do
        true -> {{:error, "not enough money"}, balance}
        false -> {:ok, balance - amount}
      end
    end)
  end

end
