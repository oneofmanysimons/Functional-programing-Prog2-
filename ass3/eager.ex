defmodule Eager do

  def eval(exp) do
    case eval_seq(exp, Env.new()) do
      :error ->
        :error
      {:ok, str} ->
        {:ok, str}
    end
  end

  def eval_expr({:atm, id}, _) do {:ok, id} end
  def eval_expr({:var, id}, env) do
    case Env.lookup(id, env) do
      nil ->
        :error
      {_, str} ->
        {:ok, str}
    end
  end
  def eval_expr({:cons, head, tail}, env) do
    case eval_expr(head, env) do
      :error ->
        :error
      {:ok, hs} ->
        case eval_expr(tail, env) do
          :error ->
            :error
        {:ok, ts} ->
          {:ok, {hs, ts}}
      end
    end
  end
  def eval_expr({:case, expr, cls}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, str} ->
        eval_cls(cls, str, env)
    end
  end
  def eval_expr({:lambda, par, free, seq}, env) do
    case Env.closure(free, env) do
      :error ->
        :error
      closure ->
        {:ok, {:closure, par, seq, closure}}
    end
  end
  def eval_expr({:apply, expr, args}, env) do
    case eval_expr(expr, env) do
      :error ->
        :error
      {:ok, {:closure, par, seq, closure}} ->
        case eval_args(args, env) do
          :error ->
            :error
          {:ok, strs} ->
            env = Env.args(par, strs, closure)
            eval_seq(seq, env)
        end
    end
  end
  def eval_expr({:fun, id}, _) do
    {par, seq} = apply(Prgm, id, [])
    {:ok, {:closure, par, seq, []}}
  end


  def eval_match(:ignore, _, env) do {:ok, env} end
  def eval_match({:atm, id}, id, env) do {:ok, env} end
  def eval_match({:var, id}, str, env) do
    case Env.lookup(id, env) do
      :nil ->
        {:ok, Env.add(id, str, env)}
      {_, ^str} ->
        {:ok, env}
      {_, _} ->
        :fail
    end
  end
  def eval_match({:cons, hp, tp}, {head, tail}, env) do
    case eval_match(hp, head, env) do
      :fail ->
        :fail
      {:ok, env} ->
        eval_match(tp, tail, env)
    end
  end
  def eval_match(_, _, _) do :fail end

  def eval_scope(pattern, env) do Env.remove(extract_vars(pattern, []), env) end

  def eval_seq([exp], env) do eval_expr(exp, env) end
  def eval_seq([{:match, pattern, exp} | tail], env) do
    case eval_expr(exp, env) do
      :error ->
        :error
      {:ok, str} ->
        env = eval_scope(pattern, env)
        case eval_match(pattern, str, env) do
          :fail ->
            :error
          {:ok, env} ->
            eval_seq(tail, env)
        end
    end
  end

  def extract_vars({:atm, _}, v) do v end
  def extract_vars({:var, id}, v) do [id | v] end
  def extract_vars({:cons, head, tail}, v) do
    extract_vars(tail, extract_vars(head, v))
  end
  def extract_vars(:ignore, v) do v end

  def eval_cls([], _, _) do :error end
  def eval_cls([{:clause, ptr, seq} | cls], str, env) do
    env = eval_scope(ptr, env)
    case eval_match(ptr, str, env) do
      :fail ->
        eval_cls(cls, str, env)
      {:ok, env} ->
        eval_seq(seq, env)
    end
  end

  def eval_args([], _) do [] end
  def eval_args([exp | tail], env) do
    case eval_expr(exp, env) do
      :error ->
        :error
      {:ok, str} ->
        {:ok, [str | eval_args(tail, env)]}
    end
  end

end
