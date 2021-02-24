.PHONY: build test package

GOOS ?= linux
GOARCH ?= amd64

build:
	mkdir -p ./bin
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -x -o ./bin/gotpl .

test:
	./test.sh

package:
	tar -cvzf gotpl-$(GOOS)-$(GOARCH).tar.gz -C bin gotpl
