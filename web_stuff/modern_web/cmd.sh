#!/bin/bash

BASEDIR=$(dirname $0)

case $1 in

  clean_host)
    docker rm $(docker ps -a -q)
    docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
    ;;
  install_erlang)
    set -e

    echo "Installing Erlang ..."

    OTP_VERSION=18.0
    REBAR_VERSION=2.6.0
    RELX_VERSION=v3.0.0

    wget http://erlang.org/download/otp_src_${OTP_VERSION}.tar.gz -O /usr/src/otp_src_${OTP_VERSION}.tar.gz

    cd /usr/src \
    && tar xf otp_src_${OTP_VERSION}.tar.gz \
    && cd otp_src_${OTP_VERSION} \
    && ./configure \
    && make \
    && make install \
    && cd / && rm -rf /usr/src/otp_src_${OTP_VERSION}

    echo "Installing Rebar ..."

    wget https://github.com/rebar/rebar/archive/${REBAR_VERSION}.tar.gz -O  /usr/src/rebar-${REBAR_VERSION}.tar.gz

    cd /usr/src \
    && tar zxf rebar-${REBAR_VERSION}.tar.gz \
    && cd rebar-${REBAR_VERSION} \
    && make \
    && cp rebar /usr/bin/rebar \
    && cd / && rm -rf /usr/src/rebar-${REBAR_VERSION}

    echo "- done."
    ;;
  install_elixir)
    set -e

    echo "Installing Elixir ..."

    ELIXIR=elixir
    ELIXIR_VERSION=1.0.5
    ELIXIR_PACKAGE=v$ELIXIR_VERSION
    ELIXIR_PACKAGE_DIR=elixir-$ELIXIR_VERSION
    ELIXIR_ARCHIVE=$ELIXIR_PACKAGE.tar.gz
    ELIXIR_DOWNLOAD=https://github.com/elixir-lang/elixir/archive/$ELIXIR_ARCHIVE

    mkdir -p $ELIXIR
    cd $ELIXIR
      curl -sSL -o $ELIXIR_ARCHIVE $ELIXIR_DOWNLOAD
      tar xfz $ELIXIR_ARCHIVE

    cd $ELIXIR_PACKAGE_DIR
      make
      make install

    echo "Install local Elixir hex and rebar"
      
    mix local.hex --force
    mix local.rebar --force

    echo "- done."
    ;;
  check_local_port)
    lsof -i :$2
    ;;
  wipe_clean)
    # Delete all containers
    docker rm $(docker ps -a -q)
    # Delete all images
    docker rmi $(docker images -q)
    ;;
  install_phx)
    mix archive.install https://github.com/phoenixframework/phoenix/releases/download/v0.14.0/phoenix_new-0.14.0.ez
    #mix archive.install hex phoenix # this is the future
    ;;
  phx_dev_release)
    MIX_ENV=dev mix do phoenix.digest, release
    ;;
  phx_prod_release)
    MIX_ENV=prod mix do phoenix.digest, release
    ;;
  new_phx)
    mix phoenix.new $2
    ;;
  phx_dev)
     #PORT=$2 iex -S mix do deps.get, compile, compile.protocols, phoenix.routes, phoenix.digest, phoenix.server
     PORT=$2 iex -S mix phoenix.server
    ;;
  phx_prod)
    #MIX_ENV=prod PORT=$2 elixir --detached -S mix phoenix.server
    echo "Starting Application"
    cd $BASEDIR && elixir -S mix phoenix.server
    ;;
  phx_db_migrate)
    echo "Running DB Migrations"
    cd $BASEDIR && mix ecto.migrate
    echo "Done with the DB Migrations"
    ;;
  phx_db_seed)
    echo "Seeding DB"
    cd $BASEDIR && mix run seeds.exs
    echo "Done Seeding the DB"
    ;;
  esac
exit 0
