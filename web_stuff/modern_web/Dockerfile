# Dockerfile for running Elixir Code

FROM ubuntu:15.04
#FROM ubuntu:14.04

MAINTAINER outcastgeek <outcastgeek+docker@gmail.com>

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

ENV OTP_VERSION 18.0
ENV REBAR_VERSION 2.6.0
ENV RELX_VERSION v3.0.0
ENV ELIXIR_VERSION 1.0.5

RUN echo "Installing Erlang ..."

RUN wget http://erlang.org/download/otp_src_${OTP_VERSION}.tar.gz -O /usr/src/otp_src_${OTP_VERSION}.tar.gz

RUN cd /usr/src \
    && tar xf otp_src_${OTP_VERSION}.tar.gz \
    && cd otp_src_${OTP_VERSION} \
    && ./configure \
    && make \
    && make install \
    && cd / && rm -rf /usr/src/otp_src_${OTP_VERSION}

RUN echo "Installing Rebar ..."

RUN wget https://github.com/rebar/rebar/archive/${REBAR_VERSION}.tar.gz -O  /usr/src/rebar-${REBAR_VERSION}.tar.gz

RUN cd /usr/src \
    && tar zxf rebar-${REBAR_VERSION}.tar.gz \
    && cd rebar-${REBAR_VERSION} \
    && make \
    && cp rebar /usr/bin/rebar \
    && cd / && rm -rf /usr/src/rebar-${REBAR_VERSION}

RUN  echo "- done."

RUN echo "Installing Elixir ..."

RUN wget https://github.com/elixir-lang/elixir/archive/v${ELIXIR_VERSION}.tar.gz -O  /usr/src/elixir-${ELIXIR_VERSION}.tar.gz

RUN cd /usr/src \
    && tar zxf elixir-${ELIXIR_VERSION}.tar.gz \
    && cd elixir-${ELIXIR_VERSION} \
    && make && cd / \
    && mv /usr/src/elixir-${ELIXIR_VERSION} /usr/local/elixir \
    && ln -s /usr/local/elixir/bin/elixir /usr/bin/elixir \
    && ln -s /usr/local/elixir/bin/iex /usr/bin/iex \
    && ln -s /usr/local/elixir/bin/mix /usr/bin/mix

RUN echo "Install local Elixir Hex"
      
RUN mix local.hex --force

#RUN echo "Install local Elixir rebar"

#RUN mix local.rebar --force

RUN echo "- done."

RUN echo "Installing Nodejs and NPM"

ENV NODE_VERSION v0.12.5

RUN mkdir /nodejs && curl http://nodejs.org/dist/${NODE_VERSION}/node-${NODE_VERSION}-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1

RUN echo "Add Node.js installation to PATH, and set"

ENV PATH $PATH:/nodejs/bin

COPY . /code

WORKDIR /code

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
