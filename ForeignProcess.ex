defmodule  ForeignProcess do
  

  def get_master_pid() do
    masterNode= :global.whereis_name(:masterNode)
    masterNode
  end

  def sort(pid,array) do
    try do
      res = GenServer.call(pid, {:sort, array})
      res
    catch
      :error -> {:failure, "The connection with P_rendezvous node is disconnected"}
    end
  end

  def gcd(pid, a,b) do
    try do
      res = GenServer.call(pid, {:gcd,a,b})
      res
    catch
      :error -> {:failure, "The connection with P_rendezvous node is disconnected"}
    end
  end

  def regex_replace(pid,regex, string, replacement) do
    try do
      res = GenServer.call(pid, {:regex_replace, regex, string, replacement})
      res
    catch
      :error -> {:failure, "The connection with P_rendezvous node is disconnected"}
    end
  end
  def create_compute_process_on_compute_node(pid) do
    try do
      res = GenServer.call(pid, {:create_compute_process_on_compute_node})
      res
    catch
      :error -> {:failure, "The connection with P_rendezvous node is disconnected"}
    end
  end


end
