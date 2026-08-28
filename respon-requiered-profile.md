# Response required — Profile Menu

Sesuain respon dan format be di mobile terkait kebutuhan profile feature

Envelope yang dipakai mobile:

```json
{
  "success": true,
  "message": "OK",
  "data": {},
  "errors": null,
  "meta": null
}
```

- Object: `/terms`, `/usage-policy`, `/about-app`
- Array: `/faq`

---

## 1. Syarat dan Ketentuan

- **GET** `/terms`
- Field: `data.html_content` (string HTML)

### Yang harus diubah dari response

Sekarang BE kirim:

```html
<h2>Syarat dan Ketentuan</h2>
<p>Gunakan aplikasi secara bertanggung jawab ...</p>
```

Masalah:

- Judul udah ada di app (`Syarat dan Ketentuan`). **Gaperlu kirim `h2` / `h1`.**
- Isi terlalu pendek. Samain struktur mock: 1 paragraf intro + `ol` 6 poin, tiap poin `strong` judul + `ul`/`li` detail.
- Tag yang di-style mobile: `p`, `ol`, `ul`, `li`, `strong`. Karakter `&` harus `&amp;`.

### `html_content` yang dimaksud

```html
<p>
  Dokumen ini adalah syarat dan ketentuan pemakaian aplikasi Kampus Esa Unggul.
  Dengan masuk dan memakai aplikasi, kamu menyetujui ketentuan di bawah ini.
</p>
<ol>
  <li>
    <strong>Ketentuan Akun</strong>
    <ul>
      <li>Jaga kerahasiaan akun dan password kamu sendiri</li>
      <li>
        Segala aktivitas di akun kamu adalah tanggung jawab kamu sepenuhnya.
      </li>
    </ul>
  </li>
  <li>
    <strong>Pengajuan Tiket &amp; Bantuan</strong>
    <ul>
      <li>
        Pastikan laporan atau kendala yang kamu sampaikan sesuai dengan fakta.
      </li>
      <li>
        Tanggapan atau penyelesaian tiket akan disesuaikan dengan antrean dan
        kebijakan bagian terkait.
      </li>
      <li>
        Aplikasi ini adalah media penghubung, sehingga tindak lanjut teknis di
        lapangan tetap mengikuti prosedur universitas.
      </li>
    </ul>
  </li>
  <li>
    <strong>Penggunaan Aplikasi</strong>
    <ul>
      <li>
        Gunakan aplikasi hanya untuk keperluan akademik dan layanan kampus yang
        resmi.
      </li>
      <li>
        Dilarang menyalahgunakan fitur aplikasi untuk kepentingan yang melanggar
        hukum atau aturan universitas.
      </li>
      <li>
        Konten, data, dan layanan di dalam aplikasi dapat berubah sewaktu-waktu
        sesuai kebijakan kampus.
      </li>
    </ul>
  </li>
  <li>
    <strong>Privasi &amp; Data</strong>
    <ul>
      <li>
        Data pribadi kamu digunakan untuk keperluan layanan akademik dan
        administrasi kampus.
      </li>
      <li>
        Kami berkomitmen menjaga keamanan data sesuai kebijakan privasi yang
        berlaku.
      </li>
      <li>
        Kamu bertanggung jawab atas kebenaran data yang kamu input di aplikasi.
      </li>
    </ul>
  </li>
  <li>
    <strong>Ketersediaan Layanan</strong>
    <ul>
      <li>
        Aplikasi dapat mengalami gangguan, pemeliharaan, atau pembaruan
        sewaktu-waktu.
      </li>
      <li>
        Universitas berhak menonaktifkan fitur tertentu bila diperlukan untuk
        keamanan atau operasional.
      </li>
    </ul>
  </li>
  <li>
    <strong>Perubahan Ketentuan</strong>
    <ul>
      <li>
        Syarat dan ketentuan ini dapat diperbarui tanpa pemberitahuan
        sebelumnya.
      </li>
      <li>
        Dengan terus menggunakan aplikasi, kamu dianggap menyetujui versi
        ketentuan terbaru.
      </li>
    </ul>
  </li>
</ol>
```

### Contoh response

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "html_content": "<p>Dokumen ini adalah syarat dan ketentuan pemakaian aplikasi Kampus Esa Unggul. Dengan masuk dan memakai aplikasi, kamu menyetujui ketentuan di bawah ini.</p><ol><li><strong>Ketentuan Akun</strong><ul><li>Jaga kerahasiaan akun dan password kamu sendiri</li><li>Segala aktivitas di akun kamu adalah tanggung jawab kamu sepenuhnya.</li></ul></li><li><strong>Pengajuan Tiket &amp; Bantuan</strong><ul><li>Pastikan laporan atau kendala yang kamu sampaikan sesuai dengan fakta.</li><li>Tanggapan atau penyelesaian tiket akan disesuaikan dengan antrean dan kebijakan bagian terkait.</li><li>Aplikasi ini adalah media penghubung, sehingga tindak lanjut teknis di lapangan tetap mengikuti prosedur universitas.</li></ul></li><li><strong>Penggunaan Aplikasi</strong><ul><li>Gunakan aplikasi hanya untuk keperluan akademik dan layanan kampus yang resmi.</li><li>Dilarang menyalahgunakan fitur aplikasi untuk kepentingan yang melanggar hukum atau aturan universitas.</li><li>Konten, data, dan layanan di dalam aplikasi dapat berubah sewaktu-waktu sesuai kebijakan kampus.</li></ul></li><li><strong>Privasi &amp; Data</strong><ul><li>Data pribadi kamu digunakan untuk keperluan layanan akademik dan administrasi kampus.</li><li>Kami berkomitmen menjaga keamanan data sesuai kebijakan privasi yang berlaku.</li><li>Kamu bertanggung jawab atas kebenaran data yang kamu input di aplikasi.</li></ul></li><li><strong>Ketersediaan Layanan</strong><ul><li>Aplikasi dapat mengalami gangguan, pemeliharaan, atau pembaruan sewaktu-waktu.</li><li>Universitas berhak menonaktifkan fitur tertentu bila diperlukan untuk keamanan atau operasional.</li></ul></li><li><strong>Perubahan Ketentuan</strong><ul><li>Syarat dan ketentuan ini dapat diperbarui tanpa pemberitahuan sebelumnya.</li><li>Dengan terus menggunakan aplikasi, kamu dianggap menyetujui versi ketentuan terbaru.</li></ul></li></ol>"
  },
  "errors": null,
  "meta": null
}
```

---

## 2. Kebijakan Penggunaan

- **GET** `/usage-policy`
- Field: `data.html_content` (string HTML)
- Aturan HTML sama dengan terms: **jangan `h1`/`h2`**, pakai `p` + `ol` + `ul` + `li` + `strong`.

Isi **beda** dari terms. Terms = perjanjian legal (akun, tiket, privasi, ketersediaan). Usage policy = cara pakai harian (tujuan, etika, batasan, konten, sanksi).

Poin usage policy:

1. Tujuan Penggunaan
2. Etika Komunikasi
3. Batasan Penggunaan
4. Hak & Kewajiban Pengguna
5. Konten yang Diunggah
6. Sanksi Penggunaan

### `html_content` yang dimaksud

```html
<p>
  Kebijakan ini mengatur cara kamu memakai aplikasi Kampus Esa Unggul
  sehari-hari. Baca aturan berikut sebelum memakai fitur akademik, profil, dan
  helpdesk.
</p>
<ol>
  <li>
    <strong>Tujuan Penggunaan</strong>
    <ul>
      <li>
        Aplikasi dipakai untuk layanan kampus: melihat info akademik, mengelola
        profil, dan mengajukan bantuan.
      </li>
      <li>
        Jangan dipakai untuk kepentingan pribadi di luar layanan universitas.
      </li>
    </ul>
  </li>
  <li>
    <strong>Etika Komunikasi</strong>
    <ul>
      <li>
        Sampaikan laporan, chat tiket, dan pesan dengan bahasa yang sopan.
      </li>
      <li>
        Dilarang mengirim konten SARA, spam, ancaman, atau informasi palsu.
      </li>
    </ul>
  </li>
  <li>
    <strong>Batasan Penggunaan</strong>
    <ul>
      <li>
        Jangan mencoba meretas, menyalin data orang lain, atau mengganggu sistem
        aplikasi.
      </li>
      <li>Jangan membagikan akun, OTP, atau akses login ke pihak lain.</li>
      <li>
        Jangan memakai bot, scraper, atau cara otomatis untuk mengambil data
        kampus.
      </li>
    </ul>
  </li>
  <li>
    <strong>Hak &amp; Kewajiban Pengguna</strong>
    <ul>
      <li>
        Kamu berhak memakai fitur sesuai status mahasiswa/pengguna yang aktif.
      </li>
      <li>
        Kamu wajib menjaga perangkat, koneksi, dan data yang kamu kirim tetap
        aman.
      </li>
      <li>
        Jika ada kesalahan data, segera perbarui lewat menu terkait atau tiket
        helpdesk.
      </li>
    </ul>
  </li>
  <li>
    <strong>Konten yang Diunggah</strong>
    <ul>
      <li>
        Foto, lampiran, dan teks yang kamu kirim harus relevan dengan keperluan
        layanan.
      </li>
      <li>
        Universitas dapat menghapus konten yang melanggar aturan tanpa
        pemberitahuan.
      </li>
    </ul>
  </li>
  <li>
    <strong>Sanksi Penggunaan</strong>
    <ul>
      <li>
        Pelanggaran dapat berakibat pembatasan fitur, penonaktifan akun, atau
        sanksi sesuai aturan kampus.
      </li>
      <li>
        Kebijakan ini dapat diperbarui. Pemakaian aplikasi setelah pembaruan
        berarti kamu menyetujui aturan terbaru.
      </li>
    </ul>
  </li>
</ol>
```

### Contoh response

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "html_content": "<p>Kebijakan ini mengatur cara kamu memakai aplikasi Kampus Esa Unggul sehari-hari. Baca aturan berikut sebelum memakai fitur akademik, profil, dan helpdesk.</p><ol><li><strong>Tujuan Penggunaan</strong><ul><li>Aplikasi dipakai untuk layanan kampus: melihat info akademik, mengelola profil, dan mengajukan bantuan.</li><li>Jangan dipakai untuk kepentingan pribadi di luar layanan universitas.</li></ul></li><li><strong>Etika Komunikasi</strong><ul><li>Sampaikan laporan, chat tiket, dan pesan dengan bahasa yang sopan.</li><li>Dilarang mengirim konten SARA, spam, ancaman, atau informasi palsu.</li></ul></li><li><strong>Batasan Penggunaan</strong><ul><li>Jangan mencoba meretas, menyalin data orang lain, atau mengganggu sistem aplikasi.</li><li>Jangan membagikan akun, OTP, atau akses login ke pihak lain.</li><li>Jangan memakai bot, scraper, atau cara otomatis untuk mengambil data kampus.</li></ul></li><li><strong>Hak &amp; Kewajiban Pengguna</strong><ul><li>Kamu berhak memakai fitur sesuai status mahasiswa/pengguna yang aktif.</li><li>Kamu wajib menjaga perangkat, koneksi, dan data yang kamu kirim tetap aman.</li><li>Jika ada kesalahan data, segera perbarui lewat menu terkait atau tiket helpdesk.</li></ul></li><li><strong>Konten yang Diunggah</strong><ul><li>Foto, lampiran, dan teks yang kamu kirim harus relevan dengan keperluan layanan.</li><li>Universitas dapat menghapus konten yang melanggar aturan tanpa pemberitahuan.</li></ul></li><li><strong>Sanksi Penggunaan</strong><ul><li>Pelanggaran dapat berakibat pembatasan fitur, penonaktifan akun, atau sanksi sesuai aturan kampus.</li><li>Kebijakan ini dapat diperbarui. Pemakaian aplikasi setelah pembaruan berarti kamu menyetujui aturan terbaru.</li></ul></li></ol>"
  },
  "errors": null,
  "meta": null
}
```

---

## 3. FAQ

- **GET** `/faq`
- `data` harus **array**, bukan object.
- Field per item: `id` (string/number), `question` (string), `answer` (string plain text, **bukan HTML**).

Jangan kirim `html_content`. Accordion di mobile pakai `question` + `answer`.

### Contoh response (samakan dengan mock, 10 item)

```json
{
  "success": true,
  "message": "OK",
  "data": [
    {
      "id": "1",
      "question": "Bagaimana cara mengubah data pribadi saya?",
      "answer": "Kamu bisa mengubah data pribadi dengan masuk ke aplikasi, buka menu \"Profil\", lalu pilih \"Edit\"."
    },
    {
      "id": "2",
      "question": "Bagaimana cara reset password?",
      "answer": "Di halaman login, ketuk \"Lupa Password\", lalu ikuti instruksi yang dikirim ke email kamu."
    },
    {
      "id": "3",
      "question": "Bagaimana cara mengajukan tiket helpdesk?",
      "answer": "Buka menu Helpdesk, ketuk \"Buat Tiket\", isi detail kendala, lalu kirim laporan kamu."
    },
    {
      "id": "4",
      "question": "Di mana saya bisa melihat jadwal akademik?",
      "answer": "Jadwal kamu tersedia di halaman Beranda pada bagian Jadwal."
    },
    {
      "id": "5",
      "question": "Siapa yang harus dihubungi jika ada kendala teknis?",
      "answer": "Kamu bisa menghubungi Helpdesk via email helpdesk@esaunggul.ac.id atau Customer Care +62-21-567-4223."
    },
    {
      "id": "6",
      "question": "Bagaimana cara melihat nilai mata kuliah?",
      "answer": "Buka menu Akademik, pilih semester yang diinginkan, lalu lihat daftar nilai pada bagian Hasil Studi."
    },
    {
      "id": "7",
      "question": "Apa yang harus dilakukan jika KRS gagal diambil?",
      "answer": "Pastikan kuota kelas masih tersedia dan status akademik kamu aktif. Jika masih gagal, ajukan tiket melalui Helpdesk."
    },
    {
      "id": "8",
      "question": "Bagaimana cara mengecek status tiket pengaduan?",
      "answer": "Buka menu Helpdesk, lalu pilih daftar tiket untuk melihat status terkini dari setiap pengaduan kamu."
    },
    {
      "id": "9",
      "question": "Apakah aplikasi bisa digunakan tanpa koneksi internet?",
      "answer": "Tidak. Aplikasi membutuhkan koneksi internet untuk menampilkan data akademik, jadwal, dan layanan helpdesk."
    },
    {
      "id": "10",
      "question": "Bagaimana jika ada perubahan syarat dan ketentuan?",
      "answer": "Setiap pembaruan akan ditampilkan di menu Syarat dan Ketentuan. Dengan terus memakai aplikasi, kamu dianggap menyetujui ketentuan terbaru."
    }
  ],
  "errors": null,
  "meta": null
}
```

---

## 4. Tentang Aplikasi

- **GET** `/about-app`
- `data` object, **bukan HTML**.
- Field:
  - `app_name` (string)
  - `version` (string)
  - `description` (string plain text)
  - `contacts` (array of `{ "label", "value" }`)

Jangan kirim `html_content`. UI sudah punya header nama + versi, paragraf deskripsi, lalu list kontak.

### Contoh response (samakan dengan mock)

```json
{
  "success": true,
  "message": "OK",
  "data": {
    "app_name": "Mobile UEU",
    "version": "1.0.0",
    "description": "Aplikasi ini adalah pusat bantuan resmi bagi mahasiswa Universitas Esa Unggul. Kami hadir untuk mempermudah kamu dalam melaporkan kendala akademik maupun fasilitas, agar proses perkuliahan jadi lebih lancar dan nyaman.",
    "contacts": [
      {
        "label": "Email",
        "value": "helpdesk@esaunggul.ac.id"
      },
      {
        "label": "Website",
        "value": "helpdesk.esaunggul.ac.id"
      },
      {
        "label": "Customer Care",
        "value": "+62-21-567-4223"
      }
    ]
  },
  "errors": null,
  "meta": null
}
```

---

## Ringkasan

| Endpoint            | `data`                                                    | Jangan                             | Harus                                                                    |
| ------------------- | --------------------------------------------------------- | ---------------------------------- | ------------------------------------------------------------------------ |
| `GET /terms`        | object `html_content`                                     | `h1`/`h2` judul, 1 paragraf pendek | `p` + `ol` 6 poin + nested `ul` + `strong` (isi mock)                    |
| `GET /usage-policy` | object `html_content`                                     | sama + jangan copy isi terms       | `p` + `ol` 6 poin **beda** (tujuan, etika, batasan, hak, konten, sanksi) |
| `GET /faq`          | **array** `{id, question, answer}`                        | object / HTML                      | 10 item mock, answer plain text                                          |
| `GET /about-app`    | object `app_name`, `version`, `description`, `contacts[]` | HTML                               | field JSON terpisah + 3 kontak mock                                      |
