defmodule Chop do

def start() do
  spawn_link(fn() -> available() end)
end

def request(chop, time) do
  send(chop, {:request, self()})
  receive do
    :granted ->
      :ok
    after time ->
    #after 1 ->
    :sorry
  end
end

def return(chop) do
  send(chop, :return)
end

def available() do
#:io.format("available state\n")
  receive do
    {:request, from} ->
      #:io.format("received request from ~w\n", [from])
      send(from, :granted)
      gone()
      :quit ->
      #:io.format("quit from available\n")
      :ok
  end
end

def gone() do
 #:io.format("in gone state\n")
  receive do
    :return ->
      #:io.format("return from gone\n")
      available()
    :quit ->
      #:io.format("die from gone\n")
      :ok
  end
end

end
