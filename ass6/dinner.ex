defmodule Dinner do

  def start(n) do
    spawn(fn() -> init(n) end)
  end

  def init(n) do
    s = 5
    c1 = Chop.start()
    c2 = Chop.start()
    c3 = Chop.start()
    c4 = Chop.start()
    c5 = Chop.start()
    ctrl = self()
    gui = Gai.start([:phil,:amy,:helen,:amber,:karl])
    t0 = :erlang.timestamp()
    p1 = Phil.start(:phil, c1,c2,n,s,ctrl,gui)
    p2 = Phil.start(:amy, c2,c3,n,s,ctrl,gui)
    p3 = Phil.start(:helen, c3,c4,n,s,ctrl,gui)
    p4 = Phil.start(:amber, c4,c5,n,s,ctrl,gui)
    p5 = Phil.start(:karl, c1,c5,n,s,ctrl,gui)
    wait(5, t0)
    dinner([p1,p2,p3,p4,p5])
  end

  def wait(0,t0) do
    t1 = :erlang.timestamp()
    IO.puts("done in #{div(:timer.now_diff(t1,t0), 1000)} ms")
    Process.exit(self, :kill)
  end
  def wait(n, t0) do
    receive do
      :done ->
        wait(n - 1, t0)
      :abort ->
        IO.puts(" abort ")
        Process.exit(self, :kill)
    end

  end

  def dinner(philos) do
    receive do
      :quit ->
        45 / 0
    end
  end

end
