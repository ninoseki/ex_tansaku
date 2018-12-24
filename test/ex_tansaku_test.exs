defmodule ExTansakuTest do
  use ExUnit.Case

  import FakeServer
  import Mock

  doctest ExTansaku

  test "paths" do
    assert length(ExTansaku.paths()) >= 1
  end

  test "url_for" do
    assert ExTansaku.url_for("http://localhost", "test.txt") == "http://localhost/test.txt"
  end

  describe "#crawl" do
    test_with_server "returns 200 with /__admin & /__cache" do
      route("/__admin", FakeServer.HTTP.Response.ok(["test"], %{"content-type" => "text/html"}))
      route("/__cache/", FakeServer.HTTP.Response.ok(["test"], %{"content-type" => "text/html"}))

      with_mocks([
        {ExTansaku, [:passthrough],
         [paths: fn -> ["__admin", "__cache/", "__pma__", "_.htpasswd"] end]}
      ]) do
        results = ExTansaku.crawl("http://#{FakeServer.address()}")

        assert length(results) == 2
        first = List.first(results)
        {_, _, res} = first
        assert res.request_url == "http://#{FakeServer.address()}/__admin"
      end
    end
  end
end
