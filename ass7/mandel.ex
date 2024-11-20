defmodule Mandel do

  def mandelbrot(width, height, x, y, k, depth) do
    trans = fn(w, h) ->
    Cmplx.new(x + k * (w - 1), y - k * (h - 1))
    end
    rows(width, height, trans, depth, [])
  end
  def rows(_width, 0, _trans, _depth, result) do
    result
  end
  def rows(width, height, trans, depth, result) do
    row = Enum.map(0..width, fn(x) -> calC(x,height,trans,depth) end)
    rows(width, height - 1, trans, depth, [row | result])
  end

  def calC(x,height,trans,depth) do
    trans.(x,height)|>
    Brot.mandelbrot(depth)|>
    Color.convert(depth)
  end

  def demo() do
    small(-2.6, 1.2, 1.2)
  end

  def demo1() do
    small(-2.2,0.9,1)
  end

  def demo2() do
    small(0.38,0.2,0.4)
  end

  def small(x0, y0, xn) do
    width = 960
    height = 540
    depth = (64 * 1)
    k = (xn - x0) / width
    image = mandelbrot(width, height, x0, y0, k, depth)
    PPM.write("small.ppm", image)
  end

end
