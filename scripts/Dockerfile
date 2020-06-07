# ---- Build Stage ----
FROM elixir:1.10.2 AS app_builder

# Set environment variables for building the application

RUN mkdir /app
WORKDIR /app

COPY lib ./lib
COPY mix.exs .
COPY mix.lock .

RUN mix local.hex --force && \
    mix local.rebar --force


RUN mix deps.get
RUN mix deps.compile

ENV LANG=C.UTF-8

RUN apt-get update 

#WORKDIR /home/app
COPY ./scripts/entrypoint.sh .

CMD ["./entrypoint.sh"]
