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
    setup_with_mocks([
      {ExTansaku, [:passthrough],
       [paths: fn -> ["__admin", "__cache/", "__pma__", "_.htpasswd"] end]}
    ]) do
      :ok
    end

    test_with_server "returns 200 with /__admin" do
      route("/__admin", FakeServer.HTTP.Response.ok(["test"], %{"content-type" => "text/html"}))
      route("/__cache/", FakeServer.HTTP.Response.ok(["test"], %{"content-type" => "text/html"}))

      results = ExTansaku.crawl("http://#{FakeServer.address()}")

      assert length(results) == 2
      first = List.first(results)
      {_, _, res} = first
      assert res.request_url == "http://#{FakeServer.address()}/__admin"
    end
  end
end
