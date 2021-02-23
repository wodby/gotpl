LDFLAGS = '-w -linkmode external -extldflags "-static"'

.PHONY: build test dist

build:
	mkdir -p ./bin
	go build -o ./bin/gotpl .

test:
	./test.sh

dist:
	rm -rf dist
	rm -f docker-gen-linux-*.tar.gz
	rm -f docker-gen-darwin-*.tar.gz

	mkdir -p dist/linux/amd64
	mkdir -p dist/linux/arm64
	mkdir -p dist/darwin/amd64
	mkdir -p dist/darwin/arm64

	GOOS=linux GOARCH=amd64 go build --ldflags $(LDFLAGS) -o dist/linux/amd64/gotpl .
	GOOS=darwin GOARCH=amd64 go build --ldflags $(LDFLAGS) -o dist/darwin/amd64/gotpl .
	GOOS=linux GOARCH=arm64 go build --ldflags $(LDFLAGS) -o dist/linux/arm64/gotpl .
	## Go 1.16 required.
	GOOS=darwin GOARCH=arm64 go build --ldflags $(LDFLAGS) -o dist/darwin/arm64/gotpl .

	tar -cvzf gotpl-linux-amd64.tar.gz -C dist/linux/amd64 gotpl
	tar -cvzf gotpl-darwin-amd64.tar.gz -C dist/darwin/amd64 gotpl
	tar -cvzf gotpl-linux-arm64.tar.gz -C dist/linux/arm64 gotpl
	tar -cvzf gotpl-darwin-arm64.tar.gz -C dist/darwin/arm64 gotpl
