defmodule GenServerExample.GameSheet do
  use GenServer

  def new(itens) do
    GenServer.start_link(__MODULE__, itens)
  end

  def add_item(pid, row_handler, item) do
    GenServer.cast pid, {:add_item_to_row, row_handler, item}
  end

  def show_items_in_row(pid, row_handler) do
    GenServer.call pid, {:result, row_handler}
  end

   def init(itens) do
     {:ok, itens}
   end

  def handle_cast({:add_item_to_row, row_handler, item}, itens) do
    {:noreply, Map.update(itens, row_handler, 0, fn(_) -> List.insert_at itens[row_handler], -1, item  end )}
  end

  def handle_call({:result, row_handler}, _from, itens) do
    itens[row_handler] |> Enum.each(&(&1 |> IO.puts))
    {:reply, itens[row_handler], itens}
  end
end
