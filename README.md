# Mobile UEU

Aplikasi mobile untuk mahasiswa **Universitas Esa Unggul**.

Mahasiswa bisa cek berbagai kebutuhan akademik kampus, misalnya jadwal kuliah, dan fitur lain yang berhubungan dengan aktivitas akademik.

## Fitur utama

- Informasi akademik (jadwal, dll)
- Konsultasi / helpdesk via chatbot
- Chat langsung ke staff (agent)

## Tech stack

- Flutter
- Riverpod
- GoRouter

## Getting started

```bash
flutter pub get
flutter run
```

Generate code (Riverpod / FlutterGen):

```bash
make gen
# atau
dart run build_runner build -d
```

## Menyambung ke backend

Aplikasi memakai backend Laravel lewat `https://api-ammar.pranalatech.com/api` (default).
Pengaturan dibaca saat build/run lewat `--dart-define` (lihat `lib/network/environment.dart`):

| Tujuan | Perintah |
|---|---|
| Backend produksi (default) | `flutter run` |
| Backend lokal (emulator Android) | `flutter run --dart-define=APP_ENV=local` (memakai `http://10.0.2.2:8000/api`) |
| Alamat lain | `flutter run --dart-define=API_BASE_URL=https://host/api` |
| Data mock tanpa backend (untuk mengerjakan UI) | `flutter run --dart-define=USE_MOCK=true` |

Catatan: base URL harus berakhiran `/api` karena semua path di `ApiService` berawalan `/v1/...`.

Akun masuk mengikuti data di backend (owner, kasir, koki). Daftar akun demo (`kasir`/`dapur`/`owner`, password `123456`)
hanya berlaku di mode mock.

### Realtime
Kasir dan dapur mendengarkan SSE `GET /v1/stream/orders` (`lib/network/staff_events_service.dart`): daftar pesanan,
batch, dan shift disegarkan otomatis, dan pesanan baru memunculkan toast. Koneksi menyambung ulang sendiri dan
melanjutkan dari event terakhir (`Last-Event-ID`). Indikator "Online/Offline" di header mengikuti status koneksi ini.

### Tes
```bash
# Tes UI (butuh mode mock)
flutter test --dart-define=USE_MOCK=true

# Parser SSE
flutter test test/sse_parser_test.dart

# Kontrak terhadap backend sungguhan (hanya membaca data)
flutter test test/api_contract_test.dart --dart-define=API_CONTRACT_PASSWORD=<password akun>

# Alur penuh pesan -> kasir -> dapur -> selesai (MEMBUAT DATA: pakai backend lokal dengan database seed)
flutter test test/api_e2e_test.dart --dart-define=API_E2E=true --dart-define=API_BASE_URL=http://127.0.0.1:8010/api
```
