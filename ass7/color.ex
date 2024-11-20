defmodule Color do

  def convert(depth, max) do
    a = depth * 4 / max
    x = trunc(a)
    y = trunc(255 * (a - x))
    case x do
      0 -> {:rgb, y, 0, 0}
      1 -> {:rgb, 255, y, 0}
      2 -> {:rgb, 255 - y, 255, 0}
      3 -> {:rgb, 0, 255, y}
      4 -> {:rgb, 0, 255 - y, 255}
    end
  end

  def print(max,max) do
    []
  end
  def print(n,max) do
    [convert(n,max) | print(n+1,max)]
  end

end
