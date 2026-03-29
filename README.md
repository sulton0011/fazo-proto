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

## Go service uchun sozlash

### 1. fazo-proto ni clone qilish

```bash
cd your-service/
git clone git@github.com:sulton0011/fazo-proto.git fazo-proto
```

### 2. buf.gen.yaml olish

```bash
cp fazo-proto/buf.gen.yaml ./buf.gen.yaml
```

Faylni oching va `directory:` qiymatini to'g'rilang:

```yaml
inputs:
  - directory: fazo-proto/proto   # fazo-proto/proto ga o'zgartiring
```

### 3. Kod generate qilish

```bash
buf generate
```

Generate bo'lgan fayllar `gen/` papkasiga tushadi. `gen/` ni `.gitignore` ga **qo'shmang** — commitlanishi kerak.

### 4. Service kodida ishlatish

```go
import (
    v1 "your-service/gen/fazo/v1"
    v1connect "your-service/gen/fazo/v1/fazov1connect"
)
```

---

## Dart (Flutter) uchun sozlash

### 1. fazo-proto ni clone qilish

```bash
cd your-flutter-app/
git clone git@github.com:sulton0011/fazo-proto.git fazo-proto
```

### 2. buf.gen.dart.yaml olish

```bash
cp fazo-proto/buf.gen.dart.yaml ./buf.gen.dart.yaml
```

Faylni oching va `directory:` qiymatini to'g'rilang:

```yaml
inputs:
  - directory: fazo-proto/proto   # fazo-proto/proto ga o'zgartiring
```

### 3. Kod generate qilish

```bash
buf generate --template buf.gen.dart.yaml
```

Generate bo'lgan Dart fayllari `gen/dart/` papkasiga tushadi.

### 4. Flutter kodida ishlatish

`pubspec.yaml` ga generate qilingan papkani qo'shing:

```yaml
dependencies:
  protobuf: ^3.1.0
  grpc: ^3.2.4
```

---

## Proto o'zgarganda yangilash

```bash
cd fazo-proto/
git pull origin master
cd ..

buf generate                                    # Go
buf generate --template buf.gen.dart.yaml       # Dart
```

---

## Makefile

`fazo-proto/` ichida Go + Dart ni bir vaqtda generate qilish:

```bash
make generate
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
