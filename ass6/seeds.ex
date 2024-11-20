defmodule Se do

  def parse() do
    file = File.read!("sample.txt")
    file = String.trim(file)
    [h|t] = String.split(file, "\r\n\r\n")
    source = Enum.map(t,fn x -> [_|t] = String.split(x, "\r\n");t end)
    map = Enum.map(source, fn x -> convert(x) end)
    [_,b] = String.split(h,"seeds: ")
    input = String.split(b," ")
    seeds = Enum.map(input, fn x -> String.to_integer(x) end)
    list = map(seeds,map)
    min2(list)
    map
  end

  def parse1() do
    file = File.read!("sample2.txt")
    file = String.trim(file)
    [h|t] = String.split(file, "\r\n\r\n")
    source = Enum.map(t,fn x -> [_|t] = String.split(x, "\r\n");t end)
    map = Enum.map(source, fn x -> convert(x) end)
    [_,b] = String.split(h,"seeds: ")
    input = String.split(b," ")
    seeds = Enum.map(input, fn x -> String.to_integer(x) end)
    [a,b,c,d] = seeds
    seeds = R.union({:uni, {a,b}, {c,d}})
    list = map(seeds,map)
    min2(list)
  end

  def min2(list) do
    [h|t] = list
    min2(h,t)
  end
  def min2(h,[]) do h end
  def min2(h,[head|t]) do
    case h < head do
      true -> min2(h,t)
      false -> min2(head,t)
    end
  end

  def convert([]) do [] end
  def convert([h|t]) do
    [dest, source, range] = String.split(h," ")
    [{String.to_integer(dest), String.to_integer(source), String.to_integer(range)}|convert(t)]
end

def map([], mapp) do [] end
def map([h|t], mapp) do
  [mapfun(h,mapp)| map(t,mapp)]
end

def mapfun(num,[]) do num end
def mapfun(num,[h|t]) do
  maped(num,h,t)
end

def maped(num,[],list) do mapfun(num,list) end
def maped(num, [h|t], list) do
  {dest,source,range} = h
  case num in source..(source+range) do
    true -> mapfun(num-source+dest,list)
    false -> maped(num,t,list)
  end
end
def maped(num,list,[]) do num end

end
