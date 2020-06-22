FROM golang:1.14.4-buster as builder

RUN mkdir -p /go/src/github.com/datanomix/kafka_exporter 
WORKDIR /go/src/github.com/datanomix/kafka_exporter
COPY . ./

RUN make build

FROM        quay.io/prometheus/busybox:latest
COPY --from=builder /go/src/github.com/datanomix/kafka_exporter/kafka_exporter /bin/kafka_exporter
 
EXPOSE     9308
ENTRYPOINT [ "/bin/kafka_exporter" ]
