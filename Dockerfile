FROM golang:1.8.0-stretch

RUN apt-get update && apt-get install -y netcat
RUN curl https://glide.sh/get | sh
RUN go get github.com/jstemmer/go-junit-report
