# fazo-proto

Fazo loyihasining barcha `.proto` fayllari. Ushbu repo faqat proto manba fayllarini saqlaydi — generate qilingan kod bu yerda **saqlanmaydi**.

## Tuzilma

```
fazo-proto/
├── proto/
│   └── fazo/v1/
│       ├── auth_service.proto
│       ├── auth_types.proto
│       ├── background_service.proto
│       ├── chat_service.proto
│       ├── comment_service.proto
│       ├── file_service.proto
│       ├── post_service.proto
│       ├── user_service.proto
│       └── common.proto
├── buf.yaml              # Buf konfiguratsiya (lint, breaking change)
├── buf.gen.yaml          # Go generation konfiguratsiya
├── buf.gen.dart.yaml     # Dart generation konfiguratsiya
├── buf.lock              # Dependency lock fayl
└── Makefile              # Generation buyruqlari
```

## Talablar

- [buf](https://buf.build/docs/installation) — proto build tool

```bash
# macOS
brew install bufbuild/buf/buf

# yoki go install
go install github.com/bufbuild/buf/cmd/buf@latest
```

---

## Serviceга qo'shish va ishlatish

### 1. fazo-proto ni service ichiga qo'shish

Service loyiha root directorysida `fazo-proto/` papkasini yarating:

```bash
# Loyiha ichida
cd your-service/

# fazo-proto ni clone qiling
git clone git@github.com:sulton0011/fazo-proto.git fazo-proto
```

Papka tuzilmasi:
```
your-service/
├── fazo-proto/        # clone qilingan proto
├── gen/               # generate qilingan Go fayllari (commitlanadi)
├── buf.gen.yaml       # service dagi generation config
└── ...
```

### 2. buf.gen.yaml sozlash

Service root directorysida `buf.gen.yaml` yarating yoki yangilang:

```yaml
version: v2
inputs:
  - directory: fazo-proto/proto   # lokal fazo-proto/proto papkasiga yo'l

plugins:
  - remote: buf.build/protocolbuffers/go
    out: gen
    opt:
      - paths=source_relative

  - remote: buf.build/grpc/go
    out: gen
    opt:
      - paths=source_relative
      - require_unimplemented_servers=false

  - remote: buf.build/connectrpc/go
    out: gen
    opt:
      - paths=source_relative

  - remote: buf.build/grpc-ecosystem/gateway
    out: gen
    opt:
      - paths=source_relative
      - generate_unbound_methods=true
```

### 3. Go moduleda import yo'lini sozlash

Proto fayllaridagi `go_package` option `your-service/gen/fazo/v1` formatida bo'lishi kerak. Fazo-proto da bu allaqachon sozlangan.

`go.mod` faylingizda tashqi proto moduli **kerak emas** — generate qilingan kod to'g'ridan-to'g'ri service moduliga tegishli bo'ladi.

### 4. Kod generate qilish

```bash
# Service root directorysida
buf generate

# Generate bo'lgan fayllar gen/ papkasiga tushadi
ls gen/fazo/v1/
```

Generate bo'lgan `gen/` papkasini `.gitignore` ga **qo'shmang** — u service repoga commitlanishi kerak.

### 5. Service kodida ishlatish

```go
import (
    v1 "your-service/gen/fazo/v1"
    v1connect "your-service/gen/fazo/v1/fazov1connect"
)
```

---

## Proto o'zgarganda yangilash

Proto manba fayllar o'zgarganda:

```bash
# 1. fazo-proto ni yangilang
cd fazo-proto/
git pull origin master
cd ..

# 2. Qayta generate qiling
buf generate

# 3. O'zgarishlarni commit qiling
git add gen/
git commit -m "chore: regenerate proto from fazo-proto"
```

---

## Dart generation

Flutter/Dart loyihalari uchun:

```bash
cd fazo-proto/

# Dart fayllarini generate qilish
make generate-dart
# yoki
buf generate --template buf.gen.dart.yaml

# Generate bo'lgan Dart fayllari gen/dart/ papkasida
ls gen/dart/
```

---

## Makefile buyruqlari

`fazo-proto/` ichida (agar proto reponing o'zida ishlayotgan bo'lsangiz):

```bash
make generate        # Go + Dart ikkalasini generate qilish
make generate-go     # Faqat Go generation
make generate-dart   # Faqat Dart generation
```

---

## Servislar

| Proto fayl | Servis | Tavsif |
|-----------|--------|--------|
| `auth_service.proto` | `AuthService` | Ro'yxatdan o'tish, kirish, token yangilash |
| `user_service.proto` | `UserService` | Foydalanuvchi profili boshqaruvi |
| `post_service.proto` | `PostService` | Post yaratish, o'chirish, lenta |
| `comment_service.proto` | `CommentService` | Kommentariylar |
| `chat_service.proto` | `ChatService` | Xabar almashish (streaming) |
| `background_service.proto` | `BackgroundService` | Profil rasmi, fon |
| `file_service.proto` | `FileService` | Fayl yuklash |
