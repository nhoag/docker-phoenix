# DOCKER-VERSION  1.6.2

FROM ubuntu:14.04
MAINTAINER Nathaniel Hoag, info@nathanielhoag.com

RUN apt-get update && \
  apt-get install -y erlang wget inotify-tools && \
  wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
  dpkg -i erlang-solutions_1.0_all.deb && \
  apt-get update && \
  apt-get install -y elixir git && \
  rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/phoenixframework/phoenix.git && \
  cd phoenix && \
  git checkout v0.9.0 && \
  mix do local.hex --force, local.rebar --force, deps.get, compile && \
  mix phoenix.new app --no-brunch /app && \
  cd /app && \
  mix do deps.get, compile

EXPOSE 4000

WORKDIR /app

ENTRYPOINT mix phoenix.server
