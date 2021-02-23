VERSION ?= latest

.PHONY: build test dist

build:
	mkdir -p ./bin
	go build -o ./bin/gotpl .

test:
	./test.sh

dist:
	rm -rf dist
	rm -f docker-gen-alpine-linux-*.tar.gz
	rm -f docker-gen-linux-*.tar.gz
	rm -f docker-gen-darwin-*.tar.gz

	mkdir -p dist/alpine-linux/amd64 && GOOS=linux GOARCH=amd64 go build -a -tags netgo -installsuffix netgo -o dist/alpine-linux/amd64/gotpl .
	mkdir -p dist/linux/amd64 && GOOS=linux GOARCH=amd64 go build -o dist/linux/amd64/gotpl .
	mkdir -p dist/darwin/amd64 && GOOS=darwin GOARCH=amd64 go build -o dist/darwin/amd64/gotpl .
	mkdir -p dist/linux/arm64 && GOOS=linux GOARCH=arm64 go build -o dist/darwin/amd64/gotpl .
	mkdir -p dist/darwin/arm64 && GOOS=darwin GOARCH=arm64 go build -o dist/darwin/amd64/gotpl .

	tar -cvzf gotpl-alpine-linux-amd64-$(VERSION).tar.gz -C dist/alpine-linux/amd64 gotpl
	tar -cvzf gotpl-linux-amd64-$(VERSION).tar.gz -C dist/linux/amd64 gotpl
	tar -cvzf gotpl-darwin-amd64-$(VERSION).tar.gz -C dist/darwin/amd64 gotpl
	tar -cvzf gotpl-linux-arm64-$(VERSION).tar.gz -C dist/linux/amd64 gotpl
	tar -cvzf gotpl-darwin-arm64-$(VERSION).tar.gz -C dist/darwin/amd64 gotpl
