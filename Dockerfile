# This image is for golang builds bundled with manngo-cli
FROM golang:1.8.0-stretch

## circleci dep
RUN apt-get update && apt-get install -y netcat

# go dependency manager
RUN curl https://glide.sh/get | sh

# format test output for circleci
RUN go get github.com/jstemmer/go-junit-report

# those are neccessary for phantomjs
RUN apt-get install -y build-essential chrpath libssl-dev libxft-dev unzip

# nodejs for mango-cli
RUN curl -sL https://deb.nodesource.com/setup_7.x -o nodesource_setup.sh \
    && bash nodesource_setup.sh \
    && apt-get install -y nodejs

# frontend build dependencies
RUN npm install -g phantomjs-prebuilt@2.1.14
RUN npm install -g mango-cli@0.32.0

# docker for building docker images (remote docker)
RUN VER="17.04.0-ce" \
    && curl -L -o /tmp/docker-$VER.tgz https://get.docker.com/builds/Linux/x86_64/docker-$VER.tgz \
    && tar -xz -C /tmp -f /tmp/docker-$VER.tgz \
    && mv /tmp/docker/* /usr/bin

# installing kubernetes controller
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl \
    && mv ./kubectl /usr/local/bin/kubectl

# installing aws-cli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

RUN mkdir -p ~/.kube

# install migrations tool for postgres
RUN go get github.com/lib/pq \
    && go get -u -d github.com/mattes/migrate/cli \
    && go build -tags 'postgres' -o /usr/local/bin/migrate github.com/mattes/migrate/cli
