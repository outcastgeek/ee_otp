# Dockerfile for running Elixir Code

#FROM ubuntu:15.04
FROM ubuntu:14.04

MAINTAINER outcastgeek <outcastgeek+docker@gmail.com>

WORKDIR /tmp

RUN echo "Running apt-get update"
RUN apt-get update
RUN echo "- done."

RUN echo "Installing Essential Tools"
RUN apt-get install -y runit locales \
                       curl wget git \
		       build-essential \
		       ca-certificates \
		       libncurses5-dev \
		       openssl libssl-dev \
		       fop xsltproc unixodbc-dev
RUN echo "- done."

# Set the locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY . /code

WORKDIR /code

RUN echo "Installing Erlang and Elixir"

RUN ./cmd.sh install_erlang

RUN ./cmd.sh install_elixir

RUN echo "- done."

RUN echo "Installing Nodejs and NPM"
RUN mkdir /nodejs && curl http://nodejs.org/dist/v0.12.4/node-v0.12.4-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
RUN echo "Add Node.js installation to PATH, and set"
ENV PATH $PATH:/nodejs/bin

RUN echo "Installing Node Libraries"
RUN npm install

RUN echo "Prepare Application"
#RUN MIX_ENV=prod mix do deps.get, compile, compile.protocols, phoenix.routes, phoenix.digest
RUN MIX_ENV=prod mix do deps.get, deps.compile, compile, compile.protocols, phoenix.routes, phoenix.digest

RUN echo "Cleanup"
RUN apt-get clean
RUN rm -r /tmp/*
RUN echo "- done."

RUN echo "Add Services"
ADD app.service /etc/service/app/run
RUN echo "- All Good!!!!"

#CMD ["/bin/bash"]
CMD ["/usr/bin/runsvdir", "/etc/service"]
