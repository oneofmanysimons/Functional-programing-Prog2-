defmodule S2 do
  def sample() do
    "???.### 1,1,3\r\n.??..??...?##. 1,1,3\r\n?#?#?#?#?#?#?#? 1,3,1,6\r\n????.#...#... 4,1,1\r\n????.######..#####. 1,6,5\r\n?###???????? 3,2,1"
  end

  def parse() do
    description = sample()
    des = String.split(description,"\r\n")
    list = rec(des)
    lista = evaluation(list)
    lista
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
    [eval(h) | evaluation(t)]
  end

  def eval([]) do [] end
  def eval([a|[b]]) do
    counting(a,b)
  end

  def counting([],[]) do 1 end
  def counting([],_) do 0 end
  def counting(_,[]) do 1 end
  def counting(list1,list2) do
    [element|rest] = list1
    [num|rest2] = list2
    case element do
      ?. -> counting(rest,list2)
      ?# -> case broken(list1,num) do
        {:ok, back} -> counting(back,rest2)
        false -> 0
      end
      ?? -> case broken(list1,num) do
         {:ok, back} -> counting(back,rest2) + counting(rest,list2)
         false -> counting(rest,list2)
      end
    end
  end

  def broken([],0) do {:ok,[]} end
  def broken([], _) do false end
  def broken(list,0) do
    [element|rest] = list
    case element do
       ?#-> false
        _ -> {:ok,rest}
    end
   end
  def broken(list,length) do
    [element|rest] = list
    case element do
      ?. -> false
      ?# -> broken(rest,length-1)
      ?? -> broken(rest,length-1)
    end
  end
end
