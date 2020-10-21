FROM bitwalker/alpine-elixir-phoenix:latest as build

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

WORKDIR /app
ENV MIX_ENV prod
ENV PORT 80

COPY . .

RUN cd assets && npm install

RUN mix deps.get
RUN mix compile
RUN mix phx.digest

EXPOSE $PORT

CMD ["mix", "phx.server"]
