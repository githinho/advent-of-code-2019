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
  def findSolution(instructions, result) do
    Enum.each(0..99, fn (x) ->
      Enum.each(0..99, fn (y) ->
        value = instructions |> beforeRunning(x, y) |> executeInstructions()
        if value == result do
          IO.inspect 100 * x + y
        end
      end)
    end)
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
