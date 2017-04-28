FROM golang:1.8.0

RUN apt-get update && apt-get install -y netcat
RUN curl https://glide.sh/get | sh
RUN go get github.com/jstemmer/go-junit-report

RUN apt-get install -y build-essential chrpath libssl-dev libxft-dev

RUN curl -sL https://deb.nodesource.com/setup_7.x -o nodesource_setup.sh \
    bash nodesource_setup.sh \
    apt-get install -y nodejs

RUN npm install -g phantomjs-prebuilt@2.1.14
RUN npm install -g mango-cli@0.32.0
