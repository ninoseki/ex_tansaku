defmodule ExTansaku do
  def paths do
    ExTansaku.Config.paths()
  end

  @spec default_user_agent() :: <<_::1024>>
  def default_user_agent do
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.79 Safari/537.36 Edge/14.14393"
  end

  def default_headers do
    [{"User-Agent", default_user_agent()}]
  end

  def default_options do
    timeout = 500
    max_redirect = 3
    [{:timeout, timeout}, {:recv_timeout, timeout}, {:max_redirect, max_redirect}]
  end

  def url_for(base_url, path) do
    "#{base_url}/#{path}"
  end

  def url_to_crawl(base_url) do
    paths()
    |> Enum.map(fn path -> url_for(base_url, path) end)
  end

  def get(url) do
    case HTTPoison.get(url, default_headers(), default_options()) do
      {:ok, res} -> {:ok, res.status_code, res}
      {:error, reason} -> {:error, reason.reason, url}
    end
  end

  def filter(result) do
    case result do
      {:ok, 200, _} -> true
      _ -> false
    end
  end

  def do_filter(urls) do
    urls
    |> Enum.map(&Task.async(fn -> get(&1) end))
    |> Enum.map(&Task.await/1)
    |> Enum.filter(&filter/1)
  end

  def crawl(base_url) do
    url_to_crawl(base_url)
    |> Enum.chunk_every(20)
    |> Enum.map(&do_filter/1)
    |> Enum.to_list()
    |> List.flatten()
  end
end
