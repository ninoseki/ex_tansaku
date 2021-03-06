# ExTansaku

[![hex.pm version](https://img.shields.io/hexpm/v/ex_tansaku.svg)](https://hex.pm/packages/ex_tansaku)
[![Build Status](https://travis-ci.org/ninoseki/ex_tansaku.svg?branch=master)](https://travis-ci.org/ninoseki/ex_tansaku)
[![Coverage Status](https://coveralls.io/repos/github/ninoseki/ex_tansaku/badge.svg?branch=master)](https://coveralls.io/github/ninoseki/ex_tansaku?branch=master)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/2401e746f4ac4f00b9eaa74f9028d65b)](https://www.codacy.com/app/ninoseki/ex_tansaku)

ExTansaku is a yet another dirbuster tool which is powered by Elixir.

Note: This is a port of [ninoseki/tansaku](https://github.com/ninoseki/tansaku).

## Installation

```sh
$ mix escript.install hex ex_tansaku
```

## Usage

```sh
$ ex_tansaku -c TARGET_URL
$ ex_tansaku -c http://localhost
```

## How it works

The tool crawls 6,000+ paths under a given URL and check whether it returns HTTP status code 200. The tool outputs a path when the path returns 200.
