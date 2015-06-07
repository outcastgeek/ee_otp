defmodule Utils.Crypto do
  def hash_string(str, hash_algo \\ :sha512) do
    :crypto.hash(hash_algo, str)
      |> :erlang.bitstring_to_list
      |> Enum.map(&(:io_lib.format("~2.16.0b", [&1])))
      |> List.flatten
      |> :erlang.list_to_bitstring
  end
end
