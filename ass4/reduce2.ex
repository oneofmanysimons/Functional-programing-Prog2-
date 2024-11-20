defmodule Red2 do

#group 1
  def length2([]) do 0 end
  def length2([_|tail]) do 1 + length(tail) end

  def prod([]) do 1 end
  def prod([head | tail]) do head * prod(tail) end

  def sum([]) do 0 end
  def sum([head|tail]) do
    head + sum(tail)
  end

  #group 2
  def even([]) do [] end
  def even([head|tail]) do
    if (rem(head,2) == 0) do
      [head|even(tail)]
    else
      even(tail)
    end
  end

  def odd([]) do [] end
  def odd([head|tail]) do
    if (rem(head,2) == 1) do
      [head|odd(tail)]
    else
      odd(tail)
    end
  end

  def div2([], _), do: []
  def div2([head | tail], divisor) when rem(head, divisor) == 0 do
    [head | div2(tail, divisor)]
  end
  def div2([_head | tail], divisor) do div2(tail, divisor) end

  #group 3
  def inc([]) do [] end
  def inc([head | tail]) do [head + 1 | inc(tail)] end

  def dec([]) do [] end
  def dec([head | tail]) do [head - 1 | dec(tail)] end

  def mul([], _) do [] end
  def mul([head|tail], value) do [head * value | mul(tail, value)] end

  def rem2([], _) do [] end
  def rem2([head | tail], divisor) do [rem(head, divisor) | rem2(tail, divisor)] end

  #take list of elements and filter out which is less then n, then sqare those number, then sum those numbers
  def sum2(list, n) do
    list
    |> Enum.filter(&(&1 < n))
    |> Enum.map(&(&1 * &1))
    |> Enum.sum()
  end
  #my own version of it
  def sum3(list, n) do
    lista = filter(list, fn(x) -> x < n end)
    lista2 = map(lista, fn(x) -> x * x end)
    sum(lista2)
  end
  #my own version of it
  def sum4(list, n) do
    list
    |> filter(&(&1 < n))
    |> map(&(&1 * &1))
    |> sum()
  end

  def map([], _) do [] end
  def map([head | tail], fun) do [fun.(head) | map(tail, fun)] end

  def reduce([], acc, _) do acc end
  def reduce([head | tail], acc, fun) do fun.(head) + reduce(tail, acc, fun) end

  def reduce1(list, acc, fun) do
    reduce1(list, acc, fun, 0)
  end

  defp reduce1([], acc, _fun, intermediate) do acc + intermediate end
  defp reduce1([head | tail], acc, fun, intermediate) do
    new_intermediate = fun.(head) + intermediate
    reduce1(tail, acc, fun, new_intermediate)
  end

  def filter([], _) do [] end
  def filter([head|tail], f) do
    if(f.(head)) do
      [head|filter(tail, f)]
    else
      filter(tail,f)
    end
  end

  def filter2(list, fun) do
    Enum.reduce(list, [], fn x, acc ->
      if fun.(x), do: [x | acc], else: acc
    end)
  end

  def filter3(list, fun) do
    for x <- list, fun.(x), do: x
  end

  def test(lst, x, y) do
    lst
    |> one(x)
    |> two(y)
    |> three()
  end

  def test2(lst, x, y) do
    three(two(one(lst, x), y))
    end


  defp one(lst, x) do Enum.map(lst, &(&1 + x)) end
  defp two(lst, y) do Enum.filter(lst, &(&1 > y)) end
  defp three(lst) do Enum.sum(lst) end

end
