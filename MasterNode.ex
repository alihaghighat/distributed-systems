defmodule  MasterNode do
  use GenServer

  @impl true
  def init(init_state) do
    {:ok, %{node_list: [], process_count: 0}}
  end
  @impl true
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: {:global, :masterNode})
  end
  @impl true
  def handle_call({:connected_compute_node,name_of_node}, from, state)  do
    if is_atom(name_of_node) do
      new_node_list = state.node_list ++ [name_of_node]
      new_state = %{state | node_list: new_node_list}
      {:reply, "ok", new_state}
    else
      {:reply, "The name of Compute Node must be atom", state}
    end

  end
  @impl true

  @impl true
  def handle_call({:sort,array},_from,state)do
    length_Node = length(state.node_list)
    if(state.process_count>0 and length_Node>0)do
      random_Node = Enum.random(state.node_list)

      try do
        computeNode= :global.whereis_name(random_Node)
        res = GenServer.call(computeNode, {:sort, array})
        {:reply, {:success, res}, state}
      catch
        :error -> {:reply, {:failure, "The node selected by is not available"}, state}
      end

    else
      if length_Node==0 do
        {:reply, {:failure, "There is no number to computing nodes"}, state}
      else
        {:reply, {:failure, "There is no process on computing nodes"}, state}
      end

    end

  end
  @impl true
  def handle_call({:gcd, a,b},_from,state)do
    length_Node = length(state.node_list)
    if(state.process_count>0 and length_Node>0)do
      random_Node = Enum.random(state.node_list)
      try do
        computeNode= :global.whereis_name(random_Node)
        res = GenServer.call(computeNode, {:gcd, a,b})
        {:reply, {:success,res}, state}
      catch
        :error -> {:reply, {:failure, "The node selected by is not available"}, state}
      end
    else
      if length_Node==0 do
        {:reply, {:failure, "There is no number to computing nodes"}, state}
      else
        {:reply, {:failure, "There is no process on computing nodes"}, state}
      end

    end

  end
  @impl true
  def handle_call({:regex_replace, regex, string, replacement},_from,state)do
    length_Node = length(state.node_list)
    if(state.process_count>0 and length_Node>0)do
      random_Node = Enum.random(state.node_list)
      try do
        computeNode= :global.whereis_name(random_Node)
        res = GenServer.call(computeNode, {:regex_replace, regex, string, replacement})
        {:reply, {:success,res}, state}
      catch
        :error -> {:reply, {:failure, "The node selected by is not available"}, state}
      end
    else
      if length_Node==0 do
        {:reply, {:failure, "There is no number to computing nodes"}, state}
      else
        {:reply, {:failure, "There is no process on computing nodes"}, state}
      end

    end

  end
  @impl true
  def handle_call({:create_compute_process_on_compute_node},_from,state)do
    new_state = %{state | process_count: state.process_count+1}
    {:reply,{:success}, new_state}
  end

end
