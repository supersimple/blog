FROM elixir:1.11.3-alpine as builder
RUN apk update && \
    apk upgrade --no-cache && \
    apk add --no-cache gcc g++ git make musl-dev && \
    mix local.rebar --force && \
    mix local.hex --force

WORKDIR /app/
ENV MIX_ENV=prod
COPY mix.* /app/
RUN mix deps.get --only prod
RUN mix deps.compile

FROM node:14.15 as frontend
WORKDIR /app/
COPY assets/package.json assets/package-lock.json /app/
COPY --from=builder /app/deps/phoenix_live_view /deps/phoenix_live_view
COPY --from=builder /app/deps/phoenix /deps/phoenix
COPY --from=builder /app/deps/phoenix_html /deps/phoenix_html
RUN npm install -g npm@6.14.9 && npm install
COPY assets /app/
RUN npm run deploy

FROM builder as releaser
ENV MIX_ENV=prod
COPY --from=frontend /priv/static /app/priv/static
COPY . /app/
RUN mix phx.digest
RUN mix release

FROM alpine:3.12
ENV LANG=C.UTF-8
RUN apk update && \
    apk add -U bash openssl && \
    rm -rf /var/cache/apk/*

RUN echo 'fs.file-max = 1048576' >> /etc/sysctl.conf
RUN echo 'fs.nr_open = 2097152' >> /etc/sysctl.conf
RUN echo "net.ipv4.tcp_mem = '10000000 10000000 10000000'" >> /etc/sysctl.conf
RUN echo "net.ipv4.tcp_rmem = '1024 4096 16384'" >> /etc/sysctl.conf
RUN echo "net.ipv4.tcp_wmem = '1024 4096 16384'" >> /etc/sysctl.conf
RUN echo 'net.core.rmem_max = 16384' >> /etc/sysctl.conf
RUN echo 'net.core.wmem_max = 16384' >> /etc/sysctl.conf
RUN mkdir /etc/security/
RUN echo '*                soft    nofile          1048576' >> /etc/security/limits.conf
RUN echo '*                hard    nofile          1048576' >> /etc/security/limits.conf
RUN echo 'root             soft    nofile          1048576' >> /etc/security/limits.conf
RUN echo 'root             hard    nofile          1048576' >> /etc/security/limits.conf

WORKDIR /app
COPY --from=releaser /app/_build/prod/rel/blog /app/

ENV MIX_ENV=prod
EXPOSE 4000
EXPOSE 9568
EXPOSE 4369

ENTRYPOINT ["bin/blog"]
CMD ["start"]
