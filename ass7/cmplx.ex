defmodule Cmplx do

  def new(r, i) do
    {r,i}
  end

  def add(a, b) do
    {r1,i1} = a
    {r2,i2} = b
    {r1+r2,i1+i2}
  end

  def sqr(a) do
    {r,i} = a
    {r*r - i*i, 2*r*i}
  end

  def sqr3(a) do
    {r,i} = a
    case r == 0 do
      true -> case i < 0 do
        true -> calc(a)
        false -> calc(a)
      end
      false -> case r > 0 do
        true -> case i >= 0 do
          true -> calc(a,0)
          false -> calc(a,0)
        end
        false -> case i >= 0 do
          true -> calc(a,1)
          false -> calc(a,1)
      end
    end
  end
end
  def sqr2(a) do
    {r,i} = a
    case r >= 0 do
      true -> case i >= 0 do
        true -> {:math.sqrt(r),:math.sqrt(i)}
        false -> {:math.sqrt(r),:math.sqrt(:math.sqrt(:math.pow(i,2)))*(-1)}
      end
      false -> case i >= 0 do
        true -> {:math.sqrt(:math.sqrt(:math.pow(r,2)))*(-1),:math.sqrt(i)}
        false -> {:math.sqrt(:math.sqrt(:math.pow(r,2)))*(-1),
        :math.sqrt(r),:math.sqrt(:math.sqrt(:math.pow(i,2)))*(-1)}
    end
  end
end
  def calc(a,k) do
    {r,i} = a
    angel = :math.atan(i/r)
    r = abs1(a)
    {:math.pow(r,(1/2)) * :math.cos((angel + (2 * k * :math.pi)) / 2),
    :math.pow(r,(1/2)) * :math.sin((angel + (2 * k * :math.pi)) / 2)}
  end
  def calc(a) do
    {r,i} = a
    case i >= 0 do
      true -> {:math.sqrt(abs1(a)/2), :math.sqrt(abs1(a)/2)}
      false -> {:math.sqrt(abs1(a)/2), (-1) * :math.sqrt(abs1(a)/2)}
    end
  end
  def abs1(a) do
    {r,i} = a
    :math.sqrt((:math.pow(r,2) + :math.pow(i,2)))
  end
end
