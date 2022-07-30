FROM golang:1.16 as builder
WORKDIR  /go/src/github.com/openshift/eventrouter
USER 0
COPY . .
RUN go build .

FROM gcr.io/pingcap-public/pingcap/alpine-glibc:alpine-3.14.3
COPY --from=builder /go/src/github.com/openshift/eventrouter/eventrouter /bin/eventrouter
CMD ["/bin/eventrouter", "-v", "3", "-logtostderr"]
LABEL version=v0.4.0
