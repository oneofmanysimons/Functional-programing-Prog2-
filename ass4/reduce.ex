defmodule Red do

  def test() do
    row = String.split(sample(),"\n")
    cards = Enum.map(rows, fn(row) -> parse(row) end)
    Enum.map(cards, fn(cards) -> points(card) end)
  end

  def points({:card, winning, you}) do
    Enum.filter(you, fn(y) -> Enum.any?(winning, fn(w) -> w == y end) end)
   end

  def parse_rows([]) do [] end
  def parse_rows([h|t]) do
    [parse(h) | parse_rows(t)]
  end

  def parse(row) do
    [_,winning,you] = String.split(row,[":","|"])
    winning = String.split(String.trim(winning))
    you = String.split(String.trim(you))
  end

end
