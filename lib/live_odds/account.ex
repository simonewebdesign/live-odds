defmodule LiveOdds.Account do

  def start do
    spawn(fn -> loop() end)
  end

  defp loop do
    receive do
      msg ->
        IO.inspect msg, label: "got a message"
        loop()
    end
  end

end
