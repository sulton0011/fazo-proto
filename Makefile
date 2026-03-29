.PHONY: generate

## Go + Dart generate qilish
generate:
	buf generate
	buf generate --template buf.gen.dart.yaml
