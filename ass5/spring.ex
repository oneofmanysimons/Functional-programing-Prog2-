defmodule SS do

  def sample() do
    "???.### 1,1,3\r\n.??..??...?##. 1,1,3\r\n?#?#?#?#?#?#?#? 1,3,1,6\r\n????.#...#... 4,1,1\r\n????.######..#####. 1,6,5\r\n?###???????? 3,2,1"
  end

  def sample1() do
    {:ok,read} = File.read("day12.csv")
    read = String.split(read,"\n")
    read = list(read)
    #read = rec2(read)
  end

  def list([]) do [] end
  def list([a|t]) do
    [String.split(a," ") | list(t)]
  end

  def parse2() do
    description = sample()
    des = String.split(description,"\r\n")
    lista = rec(des)
    list = evalut(lista)
  end

  def parse1() do
    {:ok,description} = sample1()
    des = String.split(description,"\n")
    lista = rec(des)
    evalut(lista)
  end

  def parse() do
    description = sample()
    des = String.split(description,"\r\n")
    list = rec(des)
    evaluation(list)
  end

  def rec([]) do
    []
  end
  def rec([h|t]) do
    [a,b] = String.split(h," ")
    [[String.to_charlist(a), convert(b)] | rec(t)]
  end

  def convert(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def rec2([]) do
    []
  end
  def rec2([h|t]) do
    [a,b] = h
    [[String.to_charlist(a), convert(b)] | rec2(t)]
  end

  def evaluation(list) do
    [h|t] = list
    eval(h)
  end

  def eval(list) do
    [a|[b]] = list
    summa = sum(b)
    counted = count(a)
    if counted >= summa do
      true
    else
      false
    end
  end

  #calculate an algorithm that replaces ? with # so the left side amount of # is equal
  #to the sum of the right side.

  def evalut([]) do [] end
  def evalut([[a,b]|t]) do
    [evalu([a,b]) | evalut(t)]
  end

  def evalu(list) do
    [a|[b]] = list
    counted = count(a)
    summa = sum(b)
    if counted >= summa do
      evalu(a,b,0)
    else
      false
    end
  end
  def evalu(seq,num, val) do
    if num >= val do
      true
    else
    [a|b] = seq
    case a do
      ?? -> evalu(b,num, val + 1)
      ?# -> evalu(b,num, val + 1)
      ?. -> evalu(b,num, val)
    end
  end
  end

  def length2([]) do 0 end
  def length2([_|tail]) do 1 + length(tail) end

  def count(row) do
    a = Enum.count(row, &(&1 == ?#))
    b = Enum.count(row, &(&1 == ??))
    a+b
  end

  def sum([]) do 0 end
  def sum([head|tail]) do
    head + sum(tail)
  end

end
