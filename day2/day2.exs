beforeRunning = fn (code) ->
  List.replace_at(code, 1, 12) |> List.replace_at(2, 2)
end

defmodule Execute do
  def code(code, index \\ 0) do
    case Enum.at(code, index) do
      1 -> newValue = Enum.at(code, Enum.at(code, index + 1)) + Enum.at(code, Enum.at(code, index + 2))
        newList = List.replace_at(code, Enum.at(code, index + 3), newValue)
        Execute.code(newList, index + 4)
      2 -> newValue = Enum.at(code, Enum.at(code, index + 1)) * Enum.at(code, Enum.at(code, index + 2))
        newList = List.replace_at(code, Enum.at(code, index + 3), newValue)
        Execute.code(newList, index + 4)
      99 -> Enum.at(code, 0)
      _ -> IO.puts "Problem"
    end
  end
end

case File.read("input.txt") do
  {:ok, body} ->
    IO.inspect body
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
    |> beforeRunning.()
    |> Execute.code()
  {:error, reason} ->
    IO.puts reason
end
