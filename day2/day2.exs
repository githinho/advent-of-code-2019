defmodule Execute do
  def executeInstructions(code, index \\ 0) do
    case Enum.at(code, index) do
      1 -> newValue = Enum.at(code, Enum.at(code, index + 1)) + Enum.at(code, Enum.at(code, index + 2))
        newList = List.replace_at(code, Enum.at(code, index + 3), newValue)
        Execute.executeInstructions(newList, index + 4)
      2 -> newValue = Enum.at(code, Enum.at(code, index + 1)) * Enum.at(code, Enum.at(code, index + 2))
        newList = List.replace_at(code, Enum.at(code, index + 3), newValue)
        Execute.executeInstructions(newList, index + 4)
      99 -> Enum.at(code, 0)
      _ -> IO.puts "Problem"
    end
  end

  def beforeRunning(code, noun, verb) do
    List.replace_at(code, 1, noun) |> List.replace_at(2, verb)
  end

  def numberCombinations(range) do
    for x <- range, y <- range  do
      {x, y}
    end
  end

  def calculateValue(instructions, x, y) do
    instructions
    |> Execute.beforeRunning(x, y)
    |> Execute.executeInstructions()
  end

  def findSolution(instructions, result) do
    numberCombinations(0..99)
    |> Enum.find(fn {x, y} -> calculateValue(instructions, x, y) == result end)
    |> display()
  end

  def display(tuple) do
    IO.inspect 100 * elem(tuple, 0) + elem(tuple, 1)
  end
end

case File.read("input.txt") do
  {:ok, body} ->
    IO.inspect body
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> Execute.findSolution(19690720)
  {:error, reason} ->
    IO.puts reason
end
