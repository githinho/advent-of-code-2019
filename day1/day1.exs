
defmodule Math do
  def getFuel(number) do
    trunc(div(number, 3)) - 2
  end
end

case File.read("input.txt") do
  {:ok, body} ->
    IO.inspect body
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Math.getFuel/1)
    |> Enum.sum()
  {:error, reason} ->
    IO.puts reason
end
