defmodule LiveOdds.Account do
  @moduledoc """
  A bank account.
  """

  @typedoc "A type alias for a global account name."
  @type account_name :: {:global, {module, account_id}}

  @type account_id :: pos_integer


  @doc "Open a bank account."
  @spec start_link(account_id) :: {:ok, pid} | {:error, {:already_started, pid} | term}
  def start_link(account_id) do
    Agent.start(fn -> 0 end, [name: name(account_id)])
  end


  @doc "Close a bank account."
  @spec stop(account_id) :: :ok
  def stop(account_id) do
    Agent.stop(name(account_id))
  end


  @doc "Returns the current account balance."
  @spec balance(account_id) :: integer
  def balance(account_id) do
    Agent.get(name(account_id), & &1)
  end


  @doc "Deposit money."
  @spec credit(account_id, pos_integer) :: :ok | :error
  def credit(account_id, amount) do
    if amount > 0 do
      Agent.update(name(account_id), & &1 + amount)
    else
      {:error, "not a positive credit"}
    end
  end


  @doc "Withdraw money."
  @spec debit(account_id, pos_integer) :: :ok | :error
  def debit(account_id, amount) do
    Agent.get_and_update(name(account_id), fn balance ->
      case amount > balance do
        true -> {{:error, "not enough money"}, balance}
        false -> {:ok, balance - amount}
      end
    end)
  end


  # PRIVATE

  @spec name(account_id) :: account_name
  defp name(account_id) do
    {:global, {__MODULE__, account_id}}
  end

end
