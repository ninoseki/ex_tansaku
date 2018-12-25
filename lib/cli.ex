defmodule ExTansaku.CLI do
  @moduledoc """
  ExTansaku CLI module
  """

  def main(args \\ []) do
    args
    |> parse_args
    |> execute
  end

  defp parse_args(args) do
    {options, _, _} =
      args
      |> OptionParser.parse(
        switches: [crawl: :string],
        aliases: [c: :crawl]
      )

    options
  end

  defp execute(options) do
    if options[:crawl] do
      base_url = options[:crawl]
      results = ExTansaku.crawl(base_url)

      results
      |> Enum.each(fn result ->
        {_, _, res} = result

        IO.puts(res.request_url)
      end)
    end
  end
end
