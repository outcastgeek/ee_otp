
# Dockerfile for running Elixir Code

#FROM google/debian:wheezy
FROM ubuntu:14.04

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
RUN apt-get -y install erlang
RUN echo "Installing elixir"
RUN apt-get install -y elixir

RUN echo "Install local Elixir hex and rebar"
RUN /usr/local/bin/mix local.hex --force && \
    /usr/local/bin/mix local.rebar --force

ADD . /code

WORKDIR /code

#EXPOSE 8080

ENTRYPOINT ["./run.sh"]


