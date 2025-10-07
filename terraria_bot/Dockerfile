FROM elixir:1.18.4-otp-28 AS build

ENV MIX_ENV=prod

WORKDIR /build

RUN mix local.hex --force && \
    mix local.rebar --force

COPY mix.exs mix.lock ./
COPY config config
RUN mix deps.get --only prod

RUN mix deps.get --only prod && \
    mix deps.compile

COPY . .

RUN mix release

FROM elixir:1.18.4-otp-28 AS runtime

WORKDIR /terraria_bot

COPY --from=build --chown=release:release /build/_build/prod/rel/terraria_bot .

CMD ["bin/terraria_bot", "start"]
