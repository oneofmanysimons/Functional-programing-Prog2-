defmodule Phil do

  @dreaming 80
  @eating 20
  @delay 100
  @timeout 2000

  def start(name,left,right,hunger,strength,ctrl,gui) do
    spawn_link(fn() -> dreaming(name,left,right,hunger,strength,ctrl,gui) end)
  end

  def dreaming(name,_,_,_,0,ctrl,gui) do
    :io.format("~w starved to death\n",[name])
    send(gui, {:action,name,:died})
    send(ctrl,:done)
    :ok
  end
  def dreaming(name,left,right,0,strength,ctrl,gui) do
    IO.puts("#{name} is happy (strength #{strength})")
    send(gui, {:action, name, :done})
    send(ctrl, :done)
    :ok
  end
  def dreaming(name,left,right,hunger,strength,ctrl,gui) do
    sleep(@dreaming)
    waiting(name,left,right,hunger,strength,ctrl,gui)
  end

  def waiting(name,left,right,hunger,strength,ctrl,gui) do
    send(gui, {:action, name, :waiting})
    case Chop.request(left, @timeout) do
      :ok ->
        sleep(@delay)
        case Chop.request(right, @timeout) do
          :ok -> eating(name,left,right,hunger,strength,ctrl,gui)
          :sorry ->
            Chop.return(left)
            Chop.return(right)
            send(gui, {:action, name, :leave})
            dreaming(name,left,right,hunger,strength - 1,ctrl,gui)
        end
        :sorry ->
          Chop.return(left)
        send(gui, {:action, name, :leave})
        dreaming(name,left,right,hunger,strength - 1,ctrl,gui)
    end
  end

  def eating(name,left,right,hunger,strength,ctrl,gui) do
    send(gui, {:action,name,:enter})
    sleep(@eating)
    Chop.return(left)
    Chop.return(right)
    send(gui, {:action,name,:leave})
    dreaming(name,left,right,hunger - 1,strength,ctrl,gui)
  end

  def sleep(0) do :ok end
  def sleep(t) do :timer.sleep(:rand.uniform(t)) end
  #def sleep(t) do :timer.sleep(t) end

end
