#!/bin/sh

set -e

SRC_DIR="$(git rev-parse --show-toplevel)"

OUTPUT_FILE="${OUTPUT_FILE:-./pkg/operator/assets/bindata.go}"

# ensure go-bindata
cd "${SRC_DIR}"
go build -o ./bin/go-bindata ./vendor/github.com/jteeuwen/go-bindata/go-bindata

"./bin/go-bindata" \
	-nocompress \
	-nometadata \
	-pkg "assets" \
	-o "${OUTPUT_FILE}" \
	-ignore "OWNERS" \
	-ignore "samples" \
	-ignore ".*\.sw.?" \
	./config/ && \
gofmt -s -w "${OUTPUT_FILE}"
