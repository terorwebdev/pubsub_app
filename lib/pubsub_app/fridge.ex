defmodule PubsubApp.Fridge do
  alias Phoenix.PubSub
  @pubsub_name PubsubApp.PubSub
  @pubsub_topic "fridge_updates"

  def take(product, quantity) when is_binary(product) and is_integer(quantity) do
    PubSub.broadcast(@pubsub_name, @pubsub_topic, {:take, product, quantity})
  end

  def return(product, quantity) when is_binary(product) and is_integer(quantity) do
    PubSub.broadcast(@pubsub_name, @pubsub_topic, {:return, product, quantity})
  end
end
