
# Dockerfile for running Elixir Code

#FROM google/debian:wheezy
FROM ubuntu:14.04

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "Updating ubuntu packages list"
RUN echo "deb http://packages.erlang-solutions.com/ubuntu trusty contrib" >> /etc/apt/sources.list
RUN apt-get update

WORKDIR /tmp

RUN echo "Installing Essential Tools"
RUN apt-get install -y wget git build-essential
RUN echo "Updating source.list"
RUN wget http://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc
RUN apt-key add erlang_solutions.asc
RUN echo "Running apt-get update"
RUN apt-get update
RUN echo "Installing erlang" 
RUN apt-get -y install erlang erlang-ssl erlang-inets
RUN echo "Installing elixir"
RUN apt-get install -y elixir

RUN echo "Install local Elixir hex and rebar"
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

# Fetch and install Node.js
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.10.29/node-v0.10.29-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

# Add Node.js installation to PATH, and set
# the current working directory to /app
# so future commands in this Dockerfile are easier to write
ENV PATH $PATH:/nodejs/bin

ADD . /code

WORKDIR /code

RUN echo "Installing Node Libraries"
RUN npm install

RUN echo "Prepare Application"
RUN MIX_ENV=prod mix do deps.get, compile, compile.protocols

EXPOSE 8080

ENTRYPOINT ["./run.sh"]


