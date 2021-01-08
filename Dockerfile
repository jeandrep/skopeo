FROM golang:1.12-alpine AS builder

MAINTAINER Jeandre Palm <4304398+jeandrep@users.noreply.github.com>

RUN apk add --no-cache \
    git \
    make \
    gcc \
    musl-dev \
    btrfs-progs-dev \
    lvm2-dev \
    gpgme-dev \
    glib-dev || apk update && apk upgrade

WORKDIR /go/src/github.com/containers/skopeo
RUN git clone https://github.com/containers/skopeo.git .
RUN make binary-local-static DISABLE_CGO=1


FROM alpine:3.7
run apk add --no-cache ca-certificates
COPY --from=builder /go/src/github.com/containers/skopeo/skopeo /usr/local/bin/skopeo
COPY --from=builder /go/src/github.com/containers/skopeo/default-policy.json /etc/containers/policy.json
ENTRYPOINT ["/usr/local/bin/skopeo"]
CMD ["--help"]
