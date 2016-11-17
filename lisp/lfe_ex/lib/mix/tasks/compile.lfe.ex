defmodule Mix.Tasks.Compile.Lfe do
  use Mix.Task

  @recursive true
  @manifest ".compile.lfe"

  @moduledoc """
  Force Lisp Flavored Erlang (lfe) modules to recompile
  """

  # def run(_, source_dir \\ "src") do
  def run(_) do
    project      = Mix.Project.config
    source_paths = project[:lfec_paths]
    compile_path = Mix.Project.compile_path

    _ = Mix.Project.get!
    _app_dir = Mix.Project.app_path()

    Enum.each(source_paths, fn(src_path) ->
      src_path
      |> Path.join("**/*.lfe")
      |> Path.wildcard()
      |> Enum.each(fn source ->
        IO.puts "Compiling #{inspect source}"
        # target_file = Path.join(compile_path, Path.basename(source, ".src"))
        # File.copy!(source, target_file)
        # :lfe_comp.file String.to_charlist(target_file)
        :lfe_comp.file String.to_charlist(source)
        base_file_name = Path.basename(source, '.lfe')
        target_file = "#{Path.join(compile_path, base_file_name)}.beam"
        beam_file = "#{base_file_name}.beam"
        File.rename(beam_file, target_file)
        # :lfe_comp.file(String.to_charlist(source), lfec_options)
      end)
    end)

    # _ = Mix.Project.get!
    # _app_dir = Mix.Project.app_path()

    # source_dir
    # |> Path.join("**/*.lfe")
    # |> Path.wildcard()
    # |> Enum.each(fn source ->
    #   IO.puts "Compiling #{inspect source}"
    #   :lfe_comp.file(String.to_charlist(source), {:output_dir, Path.dirname(compile_path)})
    # end)
    :ok
  end

  @doc """
  Returns Lfe manifests.
  """
  def manifests, do: [manifest]
  defp manifest, do: Path.join(Mix.Project.manifest_path, @manifest)
  # defp lfec_options do
  #   # Using Mix.Project.compile_path here raises an exception,
  #   # use Mix.Project.config[:compile_path] instead.
  #   root_path = Path.expand("../..", Mix.Project.config[:compile_path])
  #   includes = Path.wildcard(Path.join(root_path, "include"))
  #   [:debug_info] ++ Enum.map(includes, fn(path) -> {:i, path} end)
  # end
end
