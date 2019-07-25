FROM golang:alpine as multistage

ADD ./src/codeeducation /go/src/codeeducation

WORKDIR /go/src/codeeducation

RUN go install -v \
    && go build

RUN CGO_ENABLED=0 GOOS=linux go install -a -installsuffix cgo -v

FROM scratch

COPY --from=multistage /go/bin/codeeducation /go/bin/

CMD ["/go/bin/codeeducation"]