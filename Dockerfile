# Stage 1: Build the Go application
FROM golang:1.23 AS build
WORKDIR /src
COPY . .

RUN go mod download
RUN CGO_ENABLED=0 GOOS=linux go build -o /bin/app cmd/main.go

# Stage 2: Download and extract Influx CLI
FROM alpine:3.18 AS cli
RUN apk add --no-cache curl tar bzip2

WORKDIR /tmp

ENV INFLUX_VERSION=2.7.5
RUN curl -sL https://dl.influxdata.com/influxdb/releases/influxdb2-client-${INFLUX_VERSION}-linux-amd64.tar.gz | tar xz && \
    mv influx /usr/local/bin/influx

ENV RESTIC_VERSION=0.17.3
RUN curl -sL https://github.com/restic/restic/releases/download/v${RESTIC_VERSION}/restic_${RESTIC_VERSION}_linux_amd64.bz2 \
    -o restic.bz2 && \
    bunzip2 restic.bz2 && \
    chmod +x restic && \
    mv restic /usr/local/bin/restic

# Stage 3: Create minimal final image
FROM gcr.io/distroless/static-debian12
WORKDIR /
COPY --from=build /bin/app /app
COPY --from=cli /usr/local/bin/influx /usr/local/bin/influx
COPY --from=cli /usr/local/bin/restic /usr/local/bin/restic

USER 65532:65532

ENTRYPOINT ["/app"]
