defmodule Brot do

  def mandelbrot(c, m) do
    z0 = Cmplx.new(0, 0)
    i = 0
    test(i, z0, c, m)
  end

  def test(i,z,c,i) do
    0
  end
  def test(i,z,c,m) do
    if (Cmplx.abs1(z) > 2) do
      i
    else
      test(i + 1,calc(z,c),c,m)
    end
  end

  def calc(z,c) do
    Cmplx.add(Cmplx.sqr(z),c)
  end

end
