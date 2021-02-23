LDFLAGS = '-w -linkmode external -extldflags "-static"'

.PHONY: build test package

GOOS ?= linux
GOARCH ?= amd64

build:
	mkdir -p ./bin
	CGO_ENABLED=1 GOOS=$(GOOS) GOARCH=$(GOARCH) go build -x --ldflags $(LDFLAGS) -o ./bin/gotpl-$(GOOS)-$(GOARCH) .

test:
	cp ./bin/gotpl-$(GOOS)-$(GOARCH) ./bin/gotpl
	./test.sh

package:
	tar -cvzf gotpl-$(GOOS)-$(GOARCH).tar.gz -C /bin gotpl-$(GOOS)-$(GOARCH)
