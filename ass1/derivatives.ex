defmodule Deriv do

  @type literal() :: {:num, number()}
  | {:var, atom()}

  @type expr() :: {:add, expr(), expr()}
  | {:mul, expr(), expr()}
  | {:exp, expr(), literal()}
  | {:ln, expr()}
  | {:div, expr()}
  | {:sqr, expr()}
  | {:sin, expr()}
  | {:cos, expr()}
  | literal()

  def test() do
    e = {:add, {:mul, {:num, 2}, {:var, :x}}, {:num, 4}}
    d = deriv(e, :x)
    c = simplify(d)
    IO.write("expression: #{pprint(e)}\n")
    IO.write("derivative: #{pprint(d)}\n")
    IO.write("simplified: #{pprint(c)}\n")
    :ok
  end
  def test1() do
    a = {:add, {:add, {:var, :x}, {:exp, {:var, :x}, {:num, 3}}},
  {:exp, {:var, :x}, {:num, 4}}}
    b = deriv(a, :x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test2() do
    a = {:mul, {:exp, {:var, :x}, {:num, 2}}, {:var, :x}}
    b = deriv(a, :x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test3() do
    a = {:add, {:mul, {:add, {:var, :x}, {:num, 4}}, {:var, :x}},
    {:num, 2}}
    b = deriv(a, :x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test4() do
    a = {:ln, {:var, :x}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test5() do
    a = {:ln, {:mul, {:num, 2}, {:exp, {:var, :x}, {:num, 2}}}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test6() do
    a = {:div, {:exp, {:var, :x}, {:num, 2}}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test7() do
    a = {:sqr, {:exp, {:var, :x}, {:num, 4}}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test8() do
    a = {:sin, {:exp, {:var, :x}, {:num, 2}}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("calculated: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    :ok
  end
  def test9() do
    a = {:div, {:sin,{:mul, {:var, :x}, {:num, 2}}}}
    b = deriv(a,:x)
    c = calc(b, :x, 5)
    d = simplify(c)
    e = simplify(b)
    IO.write("expression: #{pprint(a)}\n")
    IO.write("derivative: #{pprint(b)}\n")
    IO.write("Calculate: #{pprint(c)}\n")
    IO.write("simplified: #{pprint(d)}\n")
    IO.write("simplified deriv: #{pprint(e)}\n")
    :ok
  end

  def deriv({:num, _}, _) do {:num, 0} end
  def deriv({:var, v}, v) do {:num, 1} end
  def deriv({:var, _}, _) do {:num, 0} end
  def deriv({:add, e1, e2}, v) do
    {:add, deriv(e1,v), deriv(e2,v)}
  end
  def deriv({:mul, e1, e2}, v) do
    {:add,
    {:mul, deriv(e1,v), e2},
    {:mul, e1, deriv(e2,v)}}
  end
  def deriv({:exp, e, {:num, n}}, v) do
    {:mul,
    {:mul, {:num, n}, {:exp, e, {:num, n-1}}},
    deriv(e, v)}
  end
  def deriv({:ln, e}, v) do
    {:mul,
    {:exp, e, {:num, -1}}, deriv(e,v)}
  end
  def deriv({:div, e}, v) do
    {:mul, {:mul, deriv(e,v), {:num, -1}}, {:exp, e, {:num, -2}}}
  end
  def deriv({:sqr, e}, v) do
    {:mul,
    {:mul, {:num, 0.5}, {:exp, e, {:num, -0.5}}},
    deriv(e, v)}
  end
  def deriv({:sin, e}, v) do
    {:mul, {:cos, e}, deriv(e,v)}
  end

  def calc({:num, n}, _, _) do {:num, n} end
  def calc({:var, v}, v, n) do {:num, n} end
  def calc({:var, v}, _, _) do {:var, v} end
  def calc({:add, e1, e2}, v, n) do
    {:add, calc(e1,v,n), calc(e2,v,n)}
  end
  def calc({:mul, e1, e2}, v, n) do
    {:mul, calc(e1,v,n), calc(e2,v,n)}
  end
  def calc({:exp, e, {:num, n}}, v, c) do
    {:exp, calc(e,v,c), {:num, n}}
  end
  def calc({:cos, e}, v, n) do
    {:cos, calc(e,v,n)}
  end
  def calc({:div, e}, v, n) do
    {:div, calc(e,v,n)}
  end
  def calc({:sin, e}, v, n) do
    {:sin, calc(e,v,n)}
  end

  def pprint({:num, n}) do "#{n}" end
  def pprint({:var, v}) do "#{v}" end
  def pprint({:add, e1, e2}) do
    "(#{pprint(e1)} + #{pprint(e2)})"
  end
  def pprint({:mul, e1, e2}) do
    "(#{pprint(e1)} * #{pprint(e2)})"
  end
  def pprint({:exp, e1, e2}) do
    "(#{pprint(e1)} ^ #{pprint(e2)})"
  end
  def pprint({:ln, e}) do
    "(ln(#{pprint(e)}))"
  end
  def pprint({:div, e}) do
    "(1/#{pprint(e)})"
  end
  def pprint({:sqr, e}) do
    "(#{pprint(e)}^0.5)"
  end
  def pprint({:sin, e}) do
    "(sin(#{pprint(e)}))"
  end
  def pprint({:cos, e}) do
    "(cos#{pprint(e)}))"
  end

  def simplify({:num, n}) do {:num, n} end
  def simplify({:var, v}) do {:var, v} end
  def simplify({:add, e1, e2}) do
    simplify_add(simplify(e1), simplify(e2))
  end
  def simplify({:mul, e1, e2}) do
    simplify_mul(simplify(e1), simplify(e2))
  end
  def simplify({:exp, e1, e2}) do
    simplify_exp(simplify(e1), simplify(e2))
  end
  def simplify({:cos, e}) do
    {:cos, e}
  end
  def simplify({:sin, e}) do
    {:sin, e}
  end

  def simplify_add({:num, 0}, e1) do e1 end
  def simplify_add(e2, {:num, 0}) do e2 end
  def simplify_add(0, {:num, e1}) do {:num, e1} end
  def simplify_add({:num, e2}, 0) do {:num, e2} end
  def simplify_add({:num, n1}, {:num, n2}) do {:num, n1+n2} end
  def simplify_add(e1, e2) do {:add, e1, e2} end

  def simplify_mul({:num, 0}, _) do 0 end
  def simplify_mul(_, {:num, 0}) do 0 end
  def simplify_mul({:num, 1}, e2) do e2 end
  def simplify_mul(e1, {:num, 1}) do e1 end
  def simplify_mul({:num, n1}, {:num, n2}) do {:num, n1*n2} end
  def simplify_mul({:num, n1}, {:mul, {:num, n2}, e2}) do
    {:mul, {:num, n1*n2}, e2}
  end
  def simplify_mul({:num, n1}, {:mul, e1, {:num, n2}}) do
    {:mul, {:num, n1*n2}, e1}
  end
  def simplify_mul({:mul, {:num, n2}, e2},{:num, n1}) do
    {:mul, {:num, n1*n2}, e2}
  end
  def simplify_mul({:mul, e1, {:num, n2}},{:num, n1}) do
    {:mul, {:num, n1*n2}, e1}
  end

  def simplify_mul(e1, e2) do {:mul, e1, e2} end

  def simplify_exp(_, {:num, 0}) do {:num, 1} end
  def simplify_exp(e1, {:num, 1}) do e1 end
  def simplify_exp({:num, 0}, _) do {:num, 0} end
  def simplify_exp({:num, 1}, _) do {:num, 1} end
  def simplify_exp({:num, n1}, {:num, n2}) do {:num, :math.pow(n1, n2)} end
  def simplify_exp(e1, e2) do {:exp, e1, e2} end

end
