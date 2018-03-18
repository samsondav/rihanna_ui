FROM elixir:1.6-slim
MAINTAINER Sam Davies <sampdavies@nested.com>

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

WORKDIR /app
ENV MIX_ENV dev

COPY . .

RUN mix deps.get
RUN MIX_ENV=prod mix compile
RUN mix compile

ENV EGGL_PORT=80
EXPOSE 80

CMD ["mix", "phx.server"]
