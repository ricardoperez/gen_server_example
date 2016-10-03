defmodule GenServerExample.GameSheet do
  use GenServer

  def new(itens) do
    GenServer.start_link(__MODULE__, itens)
  end

  def add_item(pid, item_name, item) do
    GenServer.cast pid, {:add_to_item, item_name, item}
  end

  def show_items(pid, item) do
    GenServer.cast pid, {:result, item}
  end

   def init(itens) do
     {:ok, itens}
   end

  def handle_cast({:add_to_item, item_name, item}, itens) do
    {:noreply, Map.update(itens, item_name, 0, fn(_) -> List.insert_at itens[:carros], -1, item  end )}
  end

  def handle_cast({:result, item}, itens) do
    IO.puts itens[item]
    {:noreply, itens}
  end
end
