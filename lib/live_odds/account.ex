defmodule LiveOdds.Account do
  @moduledoc """
  A bank account.
  """


  @doc "Open a bank account."
  @spec start() :: :ok
  def start do
    pid = spawn(fn -> loop(0) end)
    Process.register(pid, :account)
    :ok
  end


  @doc "Close a bank account."
  @spec stop() :: :ok
  def stop do
    Process.unregister(:account)
    :ok
  end


  @doc "Returns the current account balance."
  @spec balance() :: integer
  def balance do
    send(:account, {:balance, self()})
    receive do x -> x end
  end


  @doc "Deposit money."
  @spec credit(pos_integer) :: :ok | :error
  def credit(amount) do
    send(:account, {{:credit, amount}, self()})
    receive do x -> x end
  end


  @doc "Withdraw money."
  @spec debit(pos_integer) :: :ok | :error
  def debit(amount) do
    send(:account, {{:debit, amount}, self()})
    receive do x -> x end
  end


  defp loop(state) do
    receive do
      {:balance, from} ->
        send(from, state)
        loop(state)

      {{:credit, amount}, from} ->
        if amount > 0 do
          send(from, :ok)
          loop(state + amount)
        else
          send(from, {:error, "not a positive credit"})
          loop(state)
        end

      {{:debit, amount}, from} ->
        if amount > state do
          send(from, {:error, "not enough money"})
          loop(state)
        else
          send(from, :ok)
          loop(state - amount)
        end
    end
  end

end
