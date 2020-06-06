defmodule PubsubApp.ShoppingList do
  use GenServer
  alias Phoenix.PubSub
  @pubsub_name PubsubApp.PubSub
  @pubsub_topic "fridge_updates"

  def start_link(_state \\ []) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def get() do
    GenServer.call(__MODULE__, :get)
  end

  def test() do
    GenServer.call(__MODULE__, :test)
  end

  def init(_) do
    PubSub.subscribe(@pubsub_name, @pubsub_topic)
    {:ok, %{}}
  end 

  def handle_call(:get, _, state) do
    {:reply, state, state}
  end

  def handle_call(:test, _, state) do
    {:reply, %{"test" => "ok"}, state}
  end

  def handle_info({:take, product, quantity}, state) do
    IO.puts("Adding #{product} (#{quantity}) to shopping list")
    
    updated_state = state
      |> Map.update(product, quantity, &(&1 + quantity))

    {:noreply, updated_state}
  end
  
  def handle_info({:return, product, quantity}, state) do
    IO.puts("Removing #{product} (#{quantity}) from shopping list")

    updated_state = state
      |> Map.update(product, 0, &(&1 - quantity))
      |> Enum.reject(fn({_, v}) -> v <= 0 end)
      |> Map.new

    {:noreply, updated_state}
  end
end
