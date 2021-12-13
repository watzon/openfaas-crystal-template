FROM openfaas/classic-watchdog:0.18.0 AS watchdog

# Build stage
FROM crystallang/crystal:latest-alpine AS builder

RUN USER=root
WORKDIR /usr/src/openfaas
COPY function ./function
COPY main.cr ./main.cr

RUN cd function && shards install
RUN crystal build main.cr --release

# Runner stage
FROM alpine:3.12 as runner 

RUN apk --no-cache add curl ca-certificates \
    && addgroup -S app && adduser -S -g app app

COPY --from=watchdog /fwatchdog /usr/bin/fwatchdog
RUN chmod +x /usr/bin/fwatchdog

COPY --from=builder /usr/src/openfaas/main /usr/bin/main

HEALTHCHECK --interval=5s CMD [ -e /tmp/.lock ] || exit 1

ENV fprocess="main"

RUN ls -la /

CMD ["fwatchdog"]