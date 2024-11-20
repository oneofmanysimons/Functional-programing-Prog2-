defmodule R do
  def empty() do
    []
  end
  def range(from,to) do
    Enum.to_list(from..to)
  end
  def union(a,b) do
    [a,b]
  end
  def int(a,b) do
    MapSet.intersection(a,b)
  end
  def dif(a,b) do
    MapSet.difference(a,b)
  end
  def add(a,n) do
    Enum.map(a, fn x -> x + n end)
  end
  def last(list) do
    Enum.take(list, -1)
  end
end
