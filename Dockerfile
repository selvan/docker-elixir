FROM debian:jessie

MAINTAINER selvan <p.thamarai@gmail.com>

ADD locale.gen /etc/locale.gen

RUN apt-get update && \
	apt-get -y install locales && \
  	apt-get install -y wget curl git build-essential && \
  	rm -rf /var/lib/apt/lists/* && \
  	locale-gen

ENV LANG en_US.UTF-8

# Erlang & elixir repository
RUN wget http://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb
RUN DEBIAN_FRONTEND=noninteractive dpkg -i erlang-solutions_1.0_all.deb

RUN apt-get update

RUN apt-get install -y erlang && \
	apt-get install -y elixir && \
  	rm -rf /var/lib/apt/lists/* && \
  	rm -rf /var/cache/apt/*

# Add elixir to path
RUN PATH="/usr/local/lib/elixir/bin:$PATH"

RUN mix local.hex --force && \
    mix local.rebar --force
