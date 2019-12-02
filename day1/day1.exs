
defmodule Math do
  def getFullFuel(number) do
    fuel = getFuel(number)
    fuel + getFuelForFuel(fuel)
  end
  def getFuel(number) do
    trunc(div(number, 3)) - 2
  end
  def getFuelForFuel(number) do
    fuel = getFuel(number)
    case fuel do
      x when x < 1 -> 0
      x when x > 0 -> getFuelForFuel(fuel) + fuel
      _ -> IO.puts "Error in calculating fuel for fuel"
    end
  end
end

case File.read("input.txt") do
  {:ok, body} ->
    IO.inspect body
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> Enum.map(&Math.getFullFuel/1)
    |> Enum.sum()
  {:error, reason} ->
    IO.puts reason
end
