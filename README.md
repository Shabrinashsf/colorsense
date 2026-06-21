# ColorSense 🎨

ColorSense adalah aplikasi aksesibilitas (dibangun menggunakan **Flutter**) yang dirancang khusus untuk membantu pengguna yang mengalami buta warna _(Color Blindness / CB)_ dalam mengenali, memfilter, dan memahami warna di sekitar mereka secara _real-time_.

Aplikasi ini mencakup fitur:

- 🩺 **Tes Ishihara Terpadu** & Pengaturan Preferensi Aksesibilitas
- 📷 **Color Identifier** (_Real-time Camera_ & Pemindai Foto)
- 🌓 **Contrast Checker** (Pengecekan rasio warna berbasis standar WCAG)
- 👁️ **Simulator Buta Warna** & Penyimpanan Warna / Palet
- 🎨 **Dashboard Dinamis** (Menyesuaikan dengan profil filter pengguna)

---

## 🛠️ Persyaratan Sistem (Prerequisites)

Sebelum menjalankan proyek ini secara lokal, pastikan komputermu sudah terinstal:

1. **[Flutter SDK](https://docs.flutter.dev/get-started/install)** (Minimum versi `3.12.2` atau lebih baru).
2. **[Git](https://git-scm.com/downloads)** (Untuk melakukan _cloning_ proyek).
3. **[Google Chrome](https://www.google.com/chrome/)** (Untuk pengujian berbasis Web).
4. Code Editor pilihanmu:
   - **[Visual Studio Code (VS Code)](https://code.visualstudio.com/)** beserta ekstensi Flutter & Dart.
   - **[Android Studio](https://developer.android.com/studio)** beserta Flutter plugin (Opsional, sangat disarankan jika ingin menjalankan di Emulator Android).

---

## 📦 Instalasi & Persiapan Proyek

1. Buka Terminal / Command Prompt / PowerShell.
2. _Clone repository_ ini (jika dari remote) atau masuk ke direktori proyek lokalmu:
   ```bash
   cd path/to/colorsense
   ```
3. Unduh semua paket/dependensi yang dibutuhkan aplikasi:
   ```bash
   flutter pub get
   ```

---

## 🚀 Cara Menjalankan Aplikasi di Lokal

Proyek ini telah dikonfigurasi untuk bisa dijalankan, baik di _Web Browser_ maupun _Android/iOS_.

### Opsi 1: Menjalankan via VS Code (Target: Web/Chrome)

_Opsi ini paling ringan dan cepat untuk melihat hasil User Interface (UI)._

1. Buka _folder_ proyek `colorsense` di **VS Code**.
2. Buka **Terminal** bawaan VS Code (`Ctrl` + `` ` `` atau `View > Terminal`).
3. Ketikkan perintah berikut untuk menjalankan aplikasi langsung di browser Chrome:
   ```bash
   flutter run -d chrome
   ```
4. Tunggu beberapa saat. Chrome akan terbuka otomatis menampilkan aplikasi ColorSense.
   > **Catatan Kamera di Web:** Saat kamu mencoba fitur kamera di _Chrome_, browser akan memunculkan _pop-up_ izin penggunaan kamera/webcam di sudut kiri atas. Klik **"Allow / Izinkan"** agar aplikasinya bisa memindai warna!

### Opsi 2: Menjalankan via Android Studio (Target: Emulator Android)

_Opsi ini sangat disarankan untuk mensimulasikan penggunaan aplikasi di handphone secara persis/native._

1. Buka **Android Studio**.
2. Pilih menu **"Open"** lalu arahkan ke folder proyek `colorsense`.
3. Tunggu hingga proses _indexing_ dan _Gradle sync_ selesai.
4. **Siapkan Emulator:**
   - Buka **Device Manager** (ikon _handphone_ di bar atas).
   - Buat virtual device baru (_Create Device_) jika belum punya, contohnya "Pixel 7 API 34", lalu jalankan (klik tombol ▶️ _Play_ pada emulator).
5. Di panel bagian atas layar Android Studio, pastikan _device target_-nya menunjuk pada **Emulator** yang baru saja menyala (contoh: `sdk gphone64_arm64`).
6. Klik tombol ▶️ **Run 'main.dart'** (atau tekan `Shift + F10`).
7. Aplikasi akan di-_build_ menjadi APK lalu otomatis dipasang dan terbuka di dalam layarmu.
   > **Catatan Kamera di Emulator:** Emulator mungkin meminta izin _Camera_ dari Android UI. Secara _default_, kamera emulator menampilkan animasi pola papan catur atau _virtual scene_. Kamu bisa menghubungkan _webcam_ PC-mu dengan mengatur kamera depan/belakang emulator melalui pengaturan AVD di Android Studio.

---

## 📁 Struktur Direktori Utama

- `lib/main.dart` : Titik masuk (_entry point_) aplikasi & inisialisasi awal.
- `lib/routes/` : Konfigurasi navigasi antar halaman (menggunakan GoRouter).
- `lib/screens/` : Seluruh kumpulan layar/UI (Slicing Figma), dipisah per fitur.
- `lib/providers/` : Manajemen _state_ (penggunaan Riverpod & Hive).
- `lib/theme/` : Warna inti, _Typography_, jarak, dan _Design System_.
- `lib/utils/` : Fungsi pembantu seperti kalkulator kontras warna (WCAG).
- `lib/widgets/` : Komponen antarmuka yang dipakai ulang (_Reusable UI_ seperti _Bottom Navigation Bar_).
