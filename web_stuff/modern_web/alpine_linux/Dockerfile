
FROM gliderlabs/alpine:latest

ENV LANG en_US.UTF-8

COPY ./runtime /tmp/build
RUN cd /tmp/build && ./mkimage.sh

COPY . /code

WORKDIR /code

RUN echo "Installing Node Libraries"
RUN npm install

RUN echo "Prepare Application"
RUN MIX_ENV=prod mix do deps.get, compile, compile.protocols, phoenix.routes, phoenix.digest

CMD ["/bin/bash"]
