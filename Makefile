bootstrap: .bootstrap
.bootstrap:
	@echo "bootstrap..."
	go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	go generate -tags tools tools/tools.go
	go env -w GOFLAGS="" && go install github.com/bufbuild/buf/cmd/buf@v1.28.1

proto: bootstrap
	buf mod update && buf generate

# Lint protobuf files
protolint: bootstrap
	buf lint