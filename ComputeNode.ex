defmodule  ComputeNode do
  use GenServer
  def gcd(a, 0), do: a
  def gcd(a, b), do: gcd(b, rem(a, b))

  @impl true
  def init(init_state) do
    {:ok, init_state}
  end
  @impl true
  def start_link(name) do
    GenServer.start_link(__MODULE__, %{}, name: {:global, name})
  end

  @impl true
  def connected_node_master(name_of_node)do
    masterNode= :global.whereis_name(:masterNode)
    GenServer.call(masterNode, {:connected_compute_node,name_of_node})
  end
  @impl true
  def handle_call({:sort, list}, _from, state) do
    sorted_list = Enum.sort(list)
    {:reply, sorted_list, state}
  end
  @impl true
  def handle_call({:gcd, a,b}, _from, state) do
    gcd_res = gcd(a, b)
    {:reply, gcd_res, state}
  end
  @impl true
  def handle_call({:regex_replace, regex, string, replacement}, _from, state) do
    regex_replace = Regex.replace(regex, string, replacement)
    {:reply, regex_replace, state}
  end

end
