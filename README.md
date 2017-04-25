# JValid

[![Deps Status](https://beta.hexfaktor.org/badge/all/github/Nebo15/jvalid.svg)](https://beta.hexfaktor.org/github/Nebo15/jvalid) [![Hex.pm Downloads](https://img.shields.io/hexpm/dw/jvalid.svg?maxAge=3600)](https://hex.pm/packages/jvalid) [![Latest Version](https://img.shields.io/hexpm/v/jvalid.svg?maxAge=3600)](https://hex.pm/packages/jvalid) [![License](https://img.shields.io/hexpm/l/jvalid.svg?maxAge=3600)](https://hex.pm/packages/jvalid) [![Build Status](https://travis-ci.org/Nebo15/jvalid.svg?branch=master)](https://travis-ci.org/Nebo15/jvalid) [![Coverage Status](https://coveralls.io/repos/github/Nebo15/jvalid/badge.svg?branch=master)](https://coveralls.io/github/Nebo15/jvalid?branch=master)

We use JSON Schema validation inside our projects, but storing large schema in Elixir files looks ugly, and you can't really move them to a separate file since it will be erased during compile and release.

This module solves this issue by in-lining schemas in compilation time via Elixir macros.

## Installation

It's [available in Hex](https://hex.pm/packages/jvalid), the package can be installed as:

  1. Add `jvalid` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:jvalid, "~> 0.5.2"}]
    end
    ```

  2. Ensure `jvalid` is started before your application:

    ```elixir
    def application do
      [applications: [:jvalid]]
    end
    ```
