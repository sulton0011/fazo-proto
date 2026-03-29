.PHONY: generate generate-go generate-dart

## Generate Go + Dart
generate: generate-go generate-dart

## Generate Go (protoc-gen-go, grpc, connectrpc, grpc-gateway)
generate-go:
	buf generate

## Generate Dart (protoc-gen-dart)
generate-dart:
	buf generate --template buf.gen.dart.yaml
