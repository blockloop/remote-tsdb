FROM golang:alpine as builder
ENV GOFLAGS=-mod=vendor GO111MODULE=on CGO_ENABLED=0 GOOS=linux 
RUN mkdir -p /build
ADD . /build/
WORKDIR /build 
RUN go build -a -installsuffix cgo -ldflags '-extldflags "-static"' -o tsdb ./cmd/remote-tsdb/*.go

FROM alpine
RUN mkdir -p /var/tsdb
ADD https://github.com/Yelp/dumb-init/releases/download/v1.2.2/dumb-init_1.2.2_amd64 /usr/local/bin/dumb-init 
RUN chmod +x /usr/local/bin/dumb-init
COPY --from=builder /build/tsdb /usr/bin/
WORKDIR /var/tsdb
VOLUME /var/tsdb/data
ENTRYPOINT [ "/usr/local/bin/dumb-init" ]
CMD [ "/usr/bin/tsdb", "-data-dir", "/var/tsdb/data" ]