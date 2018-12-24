defmodule CLITest do
  use ExUnit.Case

  import ExUnit.CaptureIO
  import FakeServer
  import Mock

  doctest ExTansaku.CLI

  describe "#main" do
    test_with_server "returns 200 with /__admin" do
      route("/__admin", FakeServer.HTTP.Response.ok(["test"], %{"content-type" => "text/html"}))

      with_mocks([
        {ExTansaku, [:passthrough],
         [paths: fn -> ["__admin", "__cache/", "__pma__", "_.htpasswd"] end]}
      ]) do
        result =
          capture_io(fn ->
            ExTansaku.CLI.main(["--crawl", "http://#{FakeServer.address()}"])
          end)

        assert String.trim(result) == "http://#{FakeServer.address()}/__admin"
      end
    end
  end
end
