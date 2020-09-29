FROM alpine as build

RUN \
	apk add --no-cache go build-base git  && \
	git clone https://github.com/carlosedp/apcupsd-exporter && \
	cd apcupsd-exporter && \
	make linux/amd64

FROM alpine
COPY --from=build /apcupsd-exporter/apcupsd-exporter-linux-amd64 /sbin/apcupsd-exporter
EXPOSE ${LISTENADDR}

ENTRYPOINT ["/sbin/apcupsd-exporter"]
