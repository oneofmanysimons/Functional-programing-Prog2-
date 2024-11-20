defmodule S do
  def sample() do
    "???.### 1,1,3\r\n.??..??...?##. 1,1,3\r\n?#?#?#?#?#?#?#? 1,3,1,6\r\n????.#...#... 4,1,1\r\n????.######..#####. 1,6,5\r\n?###???????? 3,2,1"
  end

  def parse() do
    description = sample()
    des = String.split(description,"\r\n")
    list = rec(des)
    evaluation(list)
  end

  def parse2() do
    description = sample()
    des = String.split(description,"\r\n")
    list = rec(des)
    evaluation2(list)
    list
  end

  def parse2() do
    description = sample()
    des = String.split(description,"\r\n")
    list = rec(des)
    oper(list)
  end

  def oper(lista) do
    [a|b] = lista
    [c,d] = a
    num = counting(c,d)
    IO.write(num)
    IO.write(",")
    oper(b)
  end

  def rec([]) do [] end
  def rec([h|t]) do
    [a,b] = String.split(h," ")
    [[String.to_charlist(a), convert(b)] | rec(t)]
  end

  def convert(string) do
    string
    |> String.split(",")
    |> Enum.map(&String.to_integer/1)
  end

  def evaluation([]) do [] end
  def evaluation([h|t]) do
    evalu = eval(h)
    IO.write(evalu)
    IO.write(",")
    evaluation(t)
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

  def evaluation2([]) do [] end
  def evaluation2([h|t]) do
    evalu = eval2(h)
    IO.write(evalu)
    IO.write(",")
    evaluation2(t)
  end

  def eval2([]) do [] end
  def eval2([a|[b]]) do
    counting(a,b)
  end

  def counting([],[]) do
    1
  end
  def counting([],_) do
    0
  end
  def counting(_,[]) do
    1
  end
  def counting(list1,list2) do
    [a|b] = list1
    [c|d] = list2
    case a do
      ?. -> counting(b,list2)
      ?# -> case broken(list1,c) do
        {:ok, back} -> counting(back,d)
        false -> 0
      end
      ?? -> case broken(list1,c) do
         {:ok, back} -> counting(back,d) + counting(b,list2)
         false -> counting(b,list2)
      end
    end
  end

  def broken([],0) do
    {:ok,[]}
  end
  def broken([], _) do
    false
  end
  def broken(list1,0) do
    [a|b] = list1
    case a do
       ?#-> false
        _ -> {:ok,b}
    end
   end
  def broken(list1,length) do
    [a|b] = list1
    case a do
      ?. -> false
      ?# -> broken(b,length-1)
      ?? -> broken(b,length-1)
    end
  end

  def sum([]) do 0 end
  def sum([head|tail]) do
    head + sum(tail)
  end

  def count(row) do
    a = Enum.count(row, &(&1 == ?#))
    b = Enum.count(row, &(&1 == ??))
    a+b
  end

  def count2(row) do
    Enum.count(row, &(&1 == ?#))
  end

end
