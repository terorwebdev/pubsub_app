# ---- Build Stage ----
FROM elixir:1.10.2 AS app_builder

# Set environment variables for building the application

RUN mix local.hex --force && \
    mix local.rebar --force

RUN mkdir /app
WORKDIR /app

COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

RUN mix deps.get
RUN mix deps.compile

FROM ubuntu:20.04 AS app

ENV LANG=C.UTF-8

RUN apt-get update && apt-get install -y openssl apt-utils 

RUN useradd --create-home app
WORKDIR /home/app
COPY ./scripts/entrypoint.sh .

USER app

CMD ["./entrypoint.sh"]
