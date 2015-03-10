#! /bin/bash

MIX_ENV=prod mix do deps.get, compile, compile.protocols, phoenix.routes
MIX_ENV=prod PORT=8080 elixir -pa _build/prod/consolidated -S mix phoenix.server


