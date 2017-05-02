#!/usr/bin/env bash

VERSION=$1
REPO=mangoweb/golang-build
IMAGE=golang-build


docker build -t golang-build .
docker tag ${IMAGE} mangoweb/golang-build:${VERSION}
docker tag ${IMAGE} ${REPO}:latest

docker push ${REPO}:${VERSION}
docker push ${REPO}:latest
