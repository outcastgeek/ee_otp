MyPlug
======

** TODO: Add description **

_Connect to Nodes_
./run.sh app_on_node 4444 lambert chocolate_chip
HOSTNAME=$(hostname) iex --sname wobble --cookie chocolate_chip -S mix
local_node = fn name -> String.to_atom "#{name}@#{System.get_env("HOSTNAME")}" end
lb = local_node.("lambert")
Node.connect :"lambert@DTC2100CCE8906D"


