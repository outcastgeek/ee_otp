#! /bin/bash

PORT=8080 mix do deps.get, compile, phoenix.routes, phoenix.start


