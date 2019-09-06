FROM elixir:1.6-slim
MAINTAINER Sam Davies <sampdavies@gmail.com>

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix hex.info

WORKDIR /app
ENV MIX_ENV prod

ENV PORT 8080

ARG DB_PASSWORD
ENV DB_PASSWORD ${DB_PASSWORD}

RUN apt-get -qq update
RUN apt-get -y -q install curl gnupg
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get -y -q install nodejs
RUN npm install -g brunch

COPY . .

RUN cd assets && brunch build --production

RUN mix deps.get
RUN mix compile
RUN mix phx.digest

EXPOSE 8080

CMD ["mix", "phx.server"]
