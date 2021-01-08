FROM elixir:1.11.3-alpine AS build
# install build dependencies
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache gcc g++ git make musl-dev && \
    mix local.rebar --force && \
    mix local.hex --force

# prepare build dir
WORKDIR /app

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

FROM node:14.15 as frontend
WORKDIR /app/
COPY assets/package.json assets/package-lock.json /app/
COPY --from=builder /app/deps/phoenix_live_view /deps/phoenix_live_view
COPY --from=builder /app/deps/phoenix /deps/phoenix
COPY --from=builder /app/deps/phoenix_html /deps/phoenix_html
RUN npm install -g npm@6.14.9 && npm install
COPY assets /app/
RUN npm run deploy

# # build assets
# RUN npm install -g npm@6.14.9 && npm install
# COPY assets/package.json assets/package-lock.json ./assets/
# RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
COPY lib lib
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.11 AS app
RUN apk add --no-cache openssl ncurses-libs

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/blog ./

ENV HOME=/app

CMD ["bin/blog", "start"]