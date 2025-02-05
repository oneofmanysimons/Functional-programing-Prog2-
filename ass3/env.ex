defmodule Env do

  def new() do [] end

  def add(id, str, env) do [{id, str} | env] end

  def lookup(_, []) do :nil end
  def lookup(id, [{id, str} | _]) do {id, str} end
  def lookup(id, [_ | env]) do lookup(id, env) end

  def remove(_, []) do [] end
  def remove(ids, [{id, str} | env]) do
    if Enum.member?(ids, id) do
      remove(ids, env)
    else
      [{id, str} | remove(ids, env)]
    end
  end

  def closure([], _) do [] end
  def closure([head | tail], env) do
    case lookup(head, env) do
      :nil ->
        :error
      {_, str} ->
        [{head, str} | closure(tail, env)]
    end
  end

  def args(pars, strs, closure) do
    List.zip([pars, strs]) ++ closure
  end

end
