FROM golang:alpine as build

RUN \
	apk add --no-cache go build-base git  && \
	git clone https://github.com/mdlayher/apcupsd_exporter && \
	cd apcupsd_exporter && \
	go build cmd/apcupsd_exporter/main.go

FROM alpine
COPY --from=build /go/apcupsd_exporter/main /sbin/apcupsd_exporter
EXPOSE ${LISTENADDR}

ENTRYPOINT ["/sbin/apcupsd_exporter"]
