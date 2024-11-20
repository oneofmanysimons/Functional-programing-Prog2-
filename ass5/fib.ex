defmodule Fib do

  def test(m,t) do
    search(m,t,{260,40,30},{180,60,24})
  end

  def sum({:range,from,to},acc) when from > to do acc end
  def sum({:range,from,to},acc) do
    sum({:range,from+1,to},acc + from)
  end

  def search(m,t,{hm,ht,hp}=h,{lm,lt,lp}=l) when hm <= m and ht <= t and lm<= m and lt<= t do
    {h1,l1,p1} = search(m-hm,t-ht,h,l)
    {h2,l2,p2} = search(m-lm,t-lt,h,l)
    if (p1 + hp) > (p2 + lp) do
      {h1 + 1,l1,p1 + hp}
    else
      {h2,l2 + 1,p2 + lp}
    end
  end

  def search(m,t,{hm,ht,hp}=h,{lm,lt,lp}=l) when hm <= m and ht <= t do
    {h1,l1,p1} = search(m-hm,t-ht,h,l)
    {h1+1,l1,p1 + hp}
  end
  def search(m,t,{hm,ht,hp}=h,{lm,lt,lp}=l) when lm<= m and lt<= t do
    search(m-lm,t-lt,h,l)
  end
  def search(_,_,_,_) do
    {0,0,0}
  end

end
