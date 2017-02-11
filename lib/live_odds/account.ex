defmodule LiveOdds.Account do
  @moduledoc """
  A bank account.
  """

  @doc """
  Open a bank account.
  """
  def start do
    {:ok, spawn(fn -> loop(0) end)}
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
