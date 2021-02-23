.PHONY: build test dist

build:
	mkdir -p ./bin
	CGO_ENABLED=0 go build -o ./bin/gotpl .

test:
	./test.sh

dist:
	rm -rf dist
	rm -f docker-gen-linux-*.tar.gz
	rm -f docker-gen-darwin-*.tar.gz

	mkdir -p dist/linux/amd64 && CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o dist/linux/amd64/gotpl .
	mkdir -p dist/darwin/amd64 && CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build -o dist/darwin/amd64/gotpl .
	mkdir -p dist/linux/arm64 && CGO_ENABLED=0 GOOS=linux GOARCH=arm64 go build -o dist/linux/arm64/gotpl .
	## Go 1.16 required.
	mkdir -p dist/darwin/arm64 && CGO_ENABLED=0 GOOS=darwin GOARCH=arm64 go build -o dist/darwin/arm64/gotpl .

	tar -cvzf gotpl-linux-amd64.tar.gz -C dist/linux/amd64 gotpl
	tar -cvzf gotpl-darwin-amd64.tar.gz -C dist/darwin/amd64 gotpl
	tar -cvzf gotpl-linux-arm64.tar.gz -C dist/linux/arm64 gotpl
	tar -cvzf gotpl-darwin-arm64.tar.gz -C dist/darwin/arm64 gotpl
