# Building

FROM elixir:alpine as build

COPY . .

ARG MIX_ENV="prod"
ARG SECRET_KEY_BASE
ARG BOT_TOKEN

RUN mix local.hex --force && \
    mix local.rebar --force && \
    mix deps.get && \
    mkdir /export && \
    mix release --path /export/app

# Deployment

FROM erlang:alpine

COPY --from=build /export/ /opt/ 

ENTRYPOINT ["/opt/app/bin/dice"]
CMD ["start"]
