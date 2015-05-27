# Dockerfile for running Elixir Code

FROM ubuntu:15.04

MAINTAINER outcastgeek <outcastgeek+docker@gmail.com>

WORKDIR /tmp

RUN echo "Running apt-get update"
RUN apt-get update
RUN echo "- done."

RUN echo "Installing Essential Tools"
RUN apt-get install -y runit locales curl wget git build-essential ca-certificates
RUN echo "- done."

RUN echo "Updating source.list"
RUN echo "deb http://packages.erlang-solutions.com/ubuntu vivid contrib" >> /etc/apt/sources.list
RUN wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc
RUN apt-key add erlang_solutions.asc
RUN apt-get update
RUN echo "- done."

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN echo "Running apt-get update"
RUN apt-get update
RUN echo "- done."

RUN echo "Installing Erlang and Elixir"
#RUN apt-get -y install erlang erlang-ssl erlang-inets
#ADD ./cmd.sh /tmp/cmd.sh
#RUN /tmp/cmd.sh install_elixir
RUN apt-get -y install runit erlang erlang-ssl erlang-inets elixir
RUN echo "Install local Elixir hex and rebar"
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force
RUN echo "- done."

RUN echo "Installing Nodejs and NPM"
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.12.4/node-v0.12.4-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
RUN echo "Add Node.js installation to PATH, and set"
ENV PATH $PATH:/nodejs/bin

COPY . /code

WORKDIR /code

RUN echo "Installing Node Libraries"
RUN npm install

RUN echo "Prepare Application"
#RUN MIX_ENV=prod mix do deps.get, compile, compile.protocols, phoenix.routes, phoenix.digest
RUN MIX_ENV=dev mix do deps.get, compile, compile.protocols, phoenix.routes, phoenix.digest

RUN echo "Cleanup"
RUN apt-get clean
RUN rm -r /tmp/*
RUN echo "- done."

RUN echo "Add Services"
ADD app.service /etc/service/app/run
RUN echo "- All Good!!!!"

#CMD ["/bin/bash"]
CMD ["/usr/bin/runsvdir", "/etc/service"]
