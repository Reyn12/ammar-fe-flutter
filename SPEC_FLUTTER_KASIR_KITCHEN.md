# Spesifikasi Aplikasi Flutter — Kasir & Kitchen (Ammar POS)

Dokumen ini adalah **referensi fitur & layout** untuk membangun aplikasi tablet
Flutter milik **RM Ayam Bakar Ammar**. Satu aplikasi, satu halaman login, lalu
dashboard **dipisah per role** (Kasir vs Koki/Dapur).

Semua fitur di sini sudah diselaraskan dengan **BAB 3 skripsi** (SKPL-F, Definisi
Aktor, Use Case) dan **skema database (DBML)** yang ada di repo.

> **Stack (fixed):** **Riverpod (hooks_riverpod + riverpod_generator) +
> go_router + Dio + flutter_secure_storage**. Pondasi auth
> (`auth_interceptor.dart`, splash, login) sudah discaffold dengan stack ini.
> Seluruh spec ini mengikuti stack tersebut.

---

## 1. Konsep Aplikasi

- **Satu app, satu login.** Field login: `username` + `password` (DB pakai
  `username`, bukan email).
- Setelah login sukses, sistem cek `role` akun lalu **routing otomatis**:
  - `role = cashier` → **Kasir Shell** (dashboard kasir)
  - `role = kitchen` → **Kitchen Shell** (KDS)
  - `role = owner` → di luar scope skripsi (3 aktor: Pelanggan, Kasir, Koki).
    Boleh diabaikan / redirect "tidak diizinkan".
- Dua shell ini **terpisah total** (navigasi, layout, warna aksen boleh beda),
  cuma berbagi: login, session/token, HTTP client, model data, realtime layer.

```
SplashPage
   └─ cek token di secure storage
        ├─ ada & valid  → cek role → KasirShell / KitchenShell
        └─ tidak ada    → LoginPage
LoginPage
   └─ submit (username, password)
        └─ sukses → simpan token + role → route by role
```

Referensi go_router (sudah ada `app_router.dart`, `app_paths.dart`,
`root_navigator.dart`): tambahkan route `/login`, `/kasir`, `/kitchen`, dan
sisipkan **redirect guard** berbasis token + role.

---

## 2. Aktor & Ruang Lingkup (dari BAB 3)

| Aktor          | Platform           | Peran di app ini                                                   |
| -------------- | ------------------ | ------------------------------------------------------------------ |
| Pelanggan      | Browser (Next.js)  | Self-order. **Bukan** bagian app Flutter ini.                      |
| **Kasir**      | **Flutter tablet** | Terima pesanan dibayar, konfirmasi tunai, shift, kelola menu.      |
| **Koki/Dapur** | **Flutter tablet** | Lihat antrean batch, ubah status pesanan.                          |
| Midtrans       | Eksternal          | Payment gateway QRIS (dipicu dari sisi customer).                  |
| Fonnte         | Eksternal          | Kirim struk WhatsApp ke pelanggan setelah `payment_status` = paid. |
| OneSignal      | Eksternal          | Push notif ke Kasir & Koki tiap ada pesanan baru dibayar.          |

App Flutter ini **hanya menangani Kasir & Koki/Dapur**.

---

## 3. Peta Fitur → SKPL-F

| SKPL            | Fitur                                                | Modul                              |
| --------------- | ---------------------------------------------------- | ---------------------------------- |
| SKPL-F-001      | Login (Kasir & Koki)                                 | Auth (shared)                      |
| SKPL-F-006      | Konfirmasi pembayaran tunai                          | Kasir                              |
| SKPL-F-007      | Terima & lihat pesanan masuk (real-time)             | Kasir                              |
| SKPL-F-008      | Kelola shift (buka/tutup, modal awal, uang fisik)    | Kasir                              |
| SKPL-F-013      | Kelola data menu (CRUD)                              | Kasir                              |
| SKPL-F-009      | Tampilkan antrean batch (Order Batching)             | Kitchen                            |
| SKPL-F-010      | Jalankan algoritma Order Batching (max 6 nota/batch) | Sistem (tampil di Kitchen)         |
| SKPL-F-011      | Ubah status pesanan (diproses / siap saji)           | Kitchen                            |
| SKPL-F-012      | Notifikasi WhatsApp struk (Fonnte)                   | Sistem (backend)                   |
| SKPL-F-002..005 | Scan QR, lihat menu, keranjang, bayar QRIS           | Customer (Next.js) — bukan di sini |

Use case yang di-_handle_ aplikasi Flutter ini: **Login, Logout, Konfirmasi
Pembayaran Tunai, Menerima Pesanan Masuk, Kelola Shift, Kelola Menu, Tampilkan
Batch, Ubah Status Pesanan.**

---

## 4. Modul AUTH (shared)

### Halaman: LoginPage (1 halaman untuk kedua role)

Komponen layout:

- Logo + nama toko di tengah/atas.
- Card form: input **Username**, input **Password** (toggle show/hide).
- Tombol **Masuk** (loading state saat submit).
- Area pesan error (kredensial salah / field kosong).

Flow (Use Case Login):

1. Tampilkan form.
2. User isi username & password → tekan Masuk.
3. Validasi lokal (tidak boleh kosong) → validasi server.
4. Sukses → simpan token + role di `flutter_secure_storage` → route by role.
5. Gagal → pesan "Username atau password salah".

### Logout

- Tombol Keluar di masing-masing shell → dialog konfirmasi → hapus token →
  balik ke LoginPage.

---

## 5. Modul KASIR (Kasir Shell)

> **PENTING — koreksi dari UI contoh (image 1).**
> UI contoh berbentuk **POS penuh** (kasir memilih menu, ada _Order Summary_ +
> tombol _Place Order_), artinya **kasir yang membuat order**. Ini **tidak sesuai
> skripsi**: pada sistem ini **pelanggan yang self-order & bayar**, kasir hanya
> **menerima** pesanan yang sudah dibayar + **konfirmasi tunai**. Jadi layout
> kasir di bawah **berpusat pada daftar pesanan masuk, bukan input menu**.
> Panel pilih-menu ala POS hanya dipakai kembali (opsional) di sub-halaman
> **Kelola Menu**, itu pun untuk CRUD data menu, bukan bikin order.

### 5.1 Struktur navigasi Kasir

Sidebar kiri (mirip layout contoh, tapi isinya disesuaikan):

- **Pesanan Masuk** (default / home)
- **Riwayat / Transaksi**
- **Kelola Menu**
- **Shift**
- **Pengaturan** (opsional)
- Footer: profil user + status shift + tombol **Logout**.

Header global: nama toko/cabang, indikator koneksi (Online/SSE), jam, status
shift (Aktif / Belum Buka Shift).

### 5.2 Halaman: Pesanan Masuk (SKPL-F-007) — HOME kasir

Fungsi: menampilkan pesanan yang **sudah dibayar** secara real-time; kasir tidak
membuat order di sini.

Layout 2 kolom:

- **Kiri (list order):** kartu pesanan (`order`), tiap kartu berisi:
  - Kode order (`#AMRxxx`), nomor meja / label **Takeaway** (kalau `table_id`
    null), waktu masuk, `order_type` (dine_in/takeaway).
  - Badge status pembayaran: **Dibayar** (paid). Untuk order tunai yang belum
    dikonfirmasi: **Menunggu Konfirmasi Tunai**.
  - Ringkas item + total.
  - Filter/tab: Semua · Tunai belum dikonfirmasi · Dine-in · Takeaway.
- **Kanan (detail order terpilih):** rincian item + addon + catatan, subtotal,
  pajak (dari `configs` key `tax`), total. Tombol aksi kontekstual:
  - Kalau `payment_method = cash` & `payment_status = unpaid` →
    tombol **Konfirmasi Pembayaran Tunai**.
  - Kalau sudah paid → hanya info (read-only) / cetak struk (opsional).

Real-time: order baru masuk otomatis lewat **SSE** (`flutter_client_sse` sudah
di pubspec) + **push OneSignal** sebagai alert. Tidak perlu refresh manual.

### 5.3 Aksi: Konfirmasi Pembayaran Tunai (SKPL-F-006)

Flow (Use Case):

1. Kasir buka pesanan metode tunai berstatus menunggu konfirmasi.
2. Pilih pesanan → verifikasi uang diterima.
3. Tekan **Konfirmasi** → (opsional input nominal uang diterima → hitung
   kembalian).
4. Sistem set `payment_status = paid` → memicu Fonnte (WA struk) + OneSignal
   (push ke kasir & koki).
5. Extension: nominal tidak sesuai → konfirmasi dibatalkan / minta ulang.

Dialog: konfirmasi dengan total tagihan; opsional field "Uang diterima" +
tampilan "Kembalian".

### 5.4 Halaman: Shift (SKPL-F-008)

Data dari tabel `shifts`: `start_time`, `end_time`, `status` (active/closed),
`starting_cash`, `expected_cash`, `actual_cash`.

Layout:

- Kalau **belum ada shift aktif** → tampilkan tombol **Buka Shift** →
  dialog input **Modal Awal (starting_cash)**.
- Kalau **shift aktif** → tampilkan ringkasan: waktu buka, modal awal,
  perkiraan kas masuk (`expected_cash`, dihitung sistem dari transaksi tunai).
  Tombol **Tutup Shift**.
- **Tutup Shift** → dialog input **Uang Fisik (actual_cash)** → sistem
  bandingkan `expected_cash` vs `actual_cash` → tampilkan selisih (lebih/kurang).

Catatan alur: pada kartu POS contoh ada state "You are not in shift" + tombol
**Check In** — konsep ini dipertahankan (= Buka Shift). Kasir sebaiknya tidak
bisa konfirmasi tunai kalau shift belum dibuka (Use Case "Menerima Pesanan"
precondition: shift telah dibuka).

### 5.5 Halaman: Kelola Menu (SKPL-F-013)

CRUD data `products` (+ relasi `categories`, `product_addon_groups`,
`product_addons`).

Layout (boleh pakai kembali grid menu ala contoh POS, tapi untuk manajemen):

- Grid/list produk per kategori (tab: Semua, Makanan, Cemilan, Minuman, dst —
  sesuai `menu-sections` customer).
- Tiap kartu: foto (`image_url`), nama, harga, toggle **Tersedia**
  (`is_available`).
- Aksi: **Tambah menu**, **Edit**, **Hapus**.
- Form menu: nama, kategori, harga, foto, status tersedia; kelola addon group &
  addon (nama, harga, wajib/opsional, min/max qty).

### 5.6 Halaman: Transaksi / Riwayat (pendukung)

List order historis (filter tanggal / shift). Dipakai untuk rekap. Boleh
minimal — tidak wajib jadi SKPL utama, tapi berguna untuk laporan shift.

---

## 6. Modul KITCHEN / KDS (Kitchen Shell)

> **Layout kitchen sudah OK (image 2).** Bagian ini mendokumentasikan yang sudah
> ada agar konsisten saat dibangun, bukan mengubah desain.

### 6.1 Layout keseluruhan

Header KDS: judul "Kitchen Management – Ayam Bakar Ammar", indikator **Online**,
baterai, jam, tombol refresh.

Dua area utama:

- **Sidebar kiri — BATCH PREPARATION (SKPL-F-009 & 010):**
  daftar **batch** (bukan order). Batch = kumpulan item **menu yang sama** dari
  beberapa order, digabung untuk efisiensi masak.
  - Grup per kategori (MAKANAN, MINUMAN, dst).
  - Tiap batch: nama menu + **total qty** (angka besar), rincian per meja
    (Table 12 ×2, Table 04 ×3, ...), tombol **Process All**.
  - Kapasitas **maksimal 6 nota per batch** (SKPL-F-010).
- **Area kanan — kartu order (grid):** kartu per `order`
  (`#AMRxxx`, meja, customer, timer). Tiap kartu: daftar `order_items`
  - `notes` + badge status item (Belum diproses / Dimasak / Disajikan).
    Tombol aksi kartu: **Proses Makanan** / **Sajikan Makanan** / **X Menu Tersisa**.
  * **Pagination** di bawah (Page 1 of 3) — ini pagination kartu order di kanan,
    **konsep berbeda dari batch** di kiri (batch = pengelompokan menu; page =
    paginasi UI kartu).
  * Footer: indikator **Live Dashboard Synchronized** (SSE realtime).

### 6.2 Konsep Batch vs Page (penting untuk konsistensi)

- **Batch** = pengelompokan item **menu yang sama** lintas order (sidebar kiri),
  max 6 nota. Ini kontribusi akademik (Order Batching).
- **Page** = paginasi tampilan kartu order di kanan. Murni UI, tidak ada
  hubungan dengan algoritma batching.

### 6.3 Aksi: Ubah Status Pesanan (SKPL-F-011)

Status `order_items.status`: `pending → cooking → ready`
(UI: Belum diproses → Dimasak/Diproses → Disajikan/Siap).
Status `orders.status`: `pending → cooking → ready → completed`.

Flow:

- **Process All (batch)** → set semua item menu tsb di batch jadi `cooking`
  sekaligus (efisiensi: satu aksi untuk banyak order).
- **Proses Makanan (per kartu)** → set item order tsb jadi `cooking`.
- **Sajikan Makanan / centang item** → set item jadi `ready`. Kalau semua item
  di satu order `ready` → order `ready` (siap disajikan/diambil).
- Perubahan status ter-sync realtime ke kasir & board KDS lain (SSE).

---

## 7. Data & Kontrak API (dari DBML)

Model utama yang dipakai app Flutter (Kasir/Koki):

**Order**

```
id, shift_id?, table_id?, branch_id, order_type(dine_in|takeaway),
status(pending|cooking|ready|completed),
payment_method(qris|cash)?, payment_status(unpaid|paid),
total_amount, created_at, items[]
```

**OrderItem**

```
id, order_id, product_id, qty, status(pending|cooking|ready),
notes?, addons[]
```

**OrderItemAddon**: `id, order_item_id, addon_id, price`

**Product**: `id, branch_id, category_id, image_url, name, price, is_available`
**Category**: `id, name`
**AddonGroup**: `id, product_id, name, is_required, min_qty, max_qty`
**Addon**: `id, group_id, name, price, is_available`

**Shift**

```
id, user_id, start_time, end_time?, status(active|closed),
starting_cash, expected_cash?, actual_cash?
```

**User**: `id, branch_id, role(owner|cashier|kitchen), username, name`
**Table**: `id, branch_id, table_number, qr_code_url`
**Config**: `id, branch_id, key, value` (mis. `store_name`, `tax`)

### Endpoint yang perlu disiapkan backend (Laravel)

> Saat ini backend baru punya endpoint dummy products. Berikut daftar endpoint
> yang aplikasi Flutter ini butuhkan (nama bebas, ikuti konvensi API `v1`):

Auth:

- `POST /v1/auth/login` → { username, password } → { token, token_type, user{role,...} }
- `POST /v1/auth/logout`

Kasir:

- `GET /v1/orders?status=paid|pending_cash` → daftar pesanan masuk
- `GET /v1/orders/{id}` → detail order + items + addons
- `POST /v1/orders/{id}/confirm-cash` → { received_amount? } → set paid
- `GET /v1/shifts/active`
- `POST /v1/shifts/open` → { starting_cash }
- `POST /v1/shifts/{id}/close` → { actual_cash } → return { expected, actual, diff }
- `GET/POST/PUT/DELETE /v1/products` (+ categories, addons) untuk kelola menu

Kitchen:

- `GET /v1/kitchen/batches` → daftar batch (menu + qty + rincian meja, max 6 nota)
- `GET /v1/kitchen/orders` → kartu order + items (dengan pagination)
- `POST /v1/kitchen/batches/{id}/process` → Process All (set items cooking)
- `PATCH /v1/order-items/{id}/status` → { status: cooking|ready }
- `PATCH /v1/orders/{id}/status` → sinkronisasi status order

Realtime:

- **SSE** stream (mis. `GET /v1/stream/orders`) untuk live update kasir & KDS.
- **OneSignal** push untuk alert "pesanan baru dibayar" ke device kasir & koki.

---

## 8. Realtime & Notifikasi

- **SSE (`flutter_client_sse`)**: dipakai untuk sinkronisasi board KDS ("Live
  Dashboard Synchronized") dan daftar pesanan kasir tanpa refresh.
- **OneSignal**: push notification ke Kasir & Koki tiap `payment_status`
  berubah jadi `paid` (Use Case "Mengirim Notifikasi Push Pesanan").
- **Fonnte (WA)**: dipicu backend **setelah** update `payment_status` di DB
  (bukan langsung dari webhook Midtrans) — ini urusan backend, tidak ditangani
  Flutter, tapi dicatat agar alur jelas.

---

## 9. Konvensi Teknis (mengikuti repo saat ini)

- **State management:** Riverpod (`hooks_riverpod`, `riverpod_generator`).
  Provider per fitur (mis. `authProvider`, `incomingOrdersProvider`,
  `shiftProvider`, `kitchenBoardProvider`), pakai `AsyncNotifier`/`Notifier`
  untuk state yang fetch/mutasi ke API via Dio.
- **Routing:** go_router (`app_router.dart`) + redirect guard berbasis token & role.
- **HTTP:** Dio + `AuthInterceptor` (sudah ada) untuk inject token &
  handle refresh/401.
- **Storage token:** `flutter_secure_storage`.
- **Target device:** tablet (landscape). Layout Kasir & Kitchen didesain untuk
  layar lebar.
- **Struktur folder** ikuti pola `features/<nama>/{screens,models,storage,...}`
  yang sudah ada di `features/auth`.

---

## 10. Checklist Membangun

1. Auth: LoginPage + simpan token/role + redirect guard by role.
2. Shell terpisah: KasirShell (sidebar) & KitchenShell (KDS).
3. Kasir: Pesanan Masuk (SSE) → detail → Konfirmasi Tunai.
4. Kasir: Shift (buka/tutup, modal awal vs uang fisik).
5. Kasir: Kelola Menu (CRUD produk + addon).
6. Kitchen: Board (sidebar batch + grid kartu + pagination).
7. Kitchen: Process All + ubah status item (cooking/ready).
8. Integrasi OneSignal push + SSE stream.
9. Logout (dialog konfirmasi) di kedua shell.

---

_Sumber acuan: BAB 3 (SKPL-F, Definisi Aktor, Use Case), schema.dbml, modul
Next.js customer, dan mockup UI Kasir (image 1, sebagai contoh — sudah dikoreksi)
& Kitchen (image 2, sudah final)._
