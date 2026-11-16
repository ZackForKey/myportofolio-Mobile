# myportofolio_mobile

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Tugas 7

1. **Widget tree.** Widget tree adalah susunan widget yang membentuk tampilan aplikasi. Widget parent dapat mengatur tata letak dan perilaku widget child, misalnya `Scaffold` memiliki `AppBar` dan isi halaman.
2. **Widget yang digunakan.** `MaterialApp` mengatur aplikasi dan tema; `Scaffold` menyediakan kerangka halaman; `AppBar` membuat bilah atas; `SafeArea` menjaga konten dari area sistem; `LayoutBuilder` dan `ConstrainedBox` mengatur tata letak responsif; `SingleChildScrollView` memungkinkan halaman digulir; `Center`, `Padding`, `Column`, `Row`, dan `Expanded` menyusun posisi serta ruang widget; `Card` menampilkan informasi; `ClipRRect`, `Stack`, `Positioned`, dan `Container` membentuk banner dan dekorasi; `Icon` dan `Text` menampilkan ikon dan tulisan; `SizedBox` memberi jarak; `GridView.builder` menyusun menu; `Material` dan `InkWell` membuat kartu aksi yang dapat ditekan; `ScaffoldMessenger` dan `SnackBar` memberi umpan balik. `MyApp`, `MyHomePage`, `InfoCard`, dan `ItemCard` adalah widget buatan sendiri untuk aplikasi, halaman utama, kartu informasi, dan kartu aksi.
3. **MaterialApp.** `MaterialApp` mengatur hal umum seperti tema, navigasi, dan halaman awal. Widget ini lazim menjadi root karena menyediakan konfigurasi Material Design untuk halaman di bawahnya.
4. **StatelessWidget dan StatefulWidget.** `StatelessWidget` cocok untuk tampilan yang datanya tidak berubah selama widget hidup. `StatefulWidget` digunakan saat tampilan perlu diperbarui berdasarkan state yang berubah, misalnya input atau status interaksi.
5. **BuildContext.** `BuildContext` menunjukkan posisi sebuah widget di widget tree dan membantu menemukan konfigurasi atau layanan dari parent. Di `build`, context dipakai untuk membaca tema; di `ItemCard`, context dipakai untuk menampilkan `SnackBar` melalui `ScaffoldMessenger`.
6. **Hot reload dan hot restart.** Hot reload menerapkan perubahan kode sambil mempertahankan state yang sedang berjalan. Hot restart menjalankan ulang aplikasi dan mereset state; restart penuh diperlukan untuk perubahan native atau saat hot reload tidak menerapkan perubahan.

**Penggunaan AI:** ChatGPT & Gemini membantu membaca persyaratan, menyusun implementasi antarmuka, dan merapikan jawaban refleksi.
