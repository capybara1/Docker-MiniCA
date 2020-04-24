FROM golang:1.14-alpine3.11 AS build
RUN apk --no-cache add git
RUN go get github.com/jsha/minica

FROM alpine:3.11
ARG VERSION
ARG VCS_REF
ARG BUILD_DATE
LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.version="$VERSION" \
      org.label-schema.maintainer="https://github.com/capybara1/" \
      org.label-schema.url="https://github.com/capybara1/Docker-MiniCA" \
      org.label-schema.name="minica" \
      org.label-schema.license="MIT" \
      org.label-schema.vcs-url="https://github.com/capybara1/Docker-MiniCA" \
      org.label-schema.vcs-ref="$VCS_REF" \
      org.label-schema.build-date="$BUILD_DATE" \
      org.label-schema.dockerfile="/Dockerfile"
RUN apk --no-cache add iptables
COPY --from=build /go/bin/minica /usr/local/bin/minica
WORKDIR /work
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
