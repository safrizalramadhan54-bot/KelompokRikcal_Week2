# Studi Kasus: Diskon Kasir

Program Dart sederhana untuk menghitung diskon belanja di kasir, dengan struktur fungsi yang terpisah (modularisasi).

**Problem statement:** Toko membutuhkan fitur hitung diskon di kasir. Diskon hanya diberikan untuk belanja minimal Rp100.000, member mendapat diskon lebih besar, dan potongan harga dibatasi maksimal Rp25.000.

## Cara Menjalankan

```bash
dart run main.dart
```

## 1. Requirement & Business Rule

| Kode | Isi |
|---|---|
| `FR-01` | Kasir dapat memproses belanja seorang pelanggan. |
| `FR-02` | Sistem menampilkan rincian belanja, diskon, potongan, dan total bayar. |
| `BR-01` | Belanja di bawah Rp100.000 tidak mendapat diskon. |
| `BR-02` | Belanja Rp100.000 ke atas mendapat diskon 10%. |
| `BR-03` | Jika pelanggan member, diskon menjadi 15%. |
| `BR-04` | Potongan harga maksimal Rp25.000. |

## 2. Input, Output, Abstraction

| Aspek | Hasil Analisis |
|---|---|
| Input | Jumlah belanja (`double`), status member (`bool`) |
| Output | Total belanja, status member, diskon (%), potongan (Rp), total bayar |
| Abstraction | Tiga fungsi: `hitungDiskon`, `hitungPotongan`, `prosesKasir` |

## 3. Decomposition

```
prosesKasir
├── hitungDiskon     → tentukan persen diskon         (BR-01, BR-02, BR-03)
├── hitungPotongan   → hitung potongan + batas maks   (BR-04)
└── cetak hasil      → tampilkan rincian              (FR-02)
```

## 4. Flowchart

```
          START
            │
            ▼
   Input belanja, member
            │
            ▼
┌───────────────────────┐  Ya
│  belanja < 100000 ?   │────────► diskon = 0% ──────┐
└───────────────────────┘                            │
            │ Tidak                                  │
            ▼                                        │
┌───────────────────────┐  Ya                        │
│       member ?        │────────► diskon = 15% ─────┤
└───────────────────────┘                            │
            │ Tidak                                  │
            ▼                                        │
      diskon = 10% ──────────────────────────────────┤
                                                     │
            ┌────────────────────────────────────────┘
            ▼
 potongan = belanja × diskon / 100
            │
            ▼
┌───────────────────────┐  Ya
│  potongan > 25000 ?   │────────► potongan = 25000 ─┐
└───────────────────────┘                            │
            │ Tidak                                  │
            ▼                                        │
  total = belanja - potongan  ◄──────────────────────┘
            │
            ▼
   Tampilkan semua hasil
            │
            ▼
           END
```

## 5. Langkah-langkah

1. Mulai.
2. Input `belanja` dan `member`.
3. Jika `belanja < 100000`, diskon 0%.
4. Jika tidak, dan `member`, diskon 15%.
5. Jika tidak, diskon 10%.
6. Hitung `potongan = belanja × diskon / 100`.
7. Jika `potongan > 25000`, set `potongan = 25000`.
8. Hitung `total = belanja - potongan`.
9. Tampilkan hasil.
10. Selesai.

## 6. Kode Dart

```dart
void main() {
  prosesKasir(80000, false);
  prosesKasir(150000, false);
  prosesKasir(150000, true);
  prosesKasir(300000, true);
}

double hitungDiskon(double belanja, bool member) {
  if (belanja < 100000) return 0;
  return member ? 15 : 10;
}

double hitungPotongan(double belanja, double diskon) {
  double potongan = belanja * diskon / 100;
  return potongan > 25000 ? 25000 : potongan;
}

void prosesKasir(double belanja, bool member) {
  double diskon = hitungDiskon(belanja, member);
  double potongan = hitungPotongan(belanja, diskon);

  print("Total Belanja : Rp$belanja");
  print("Member        : $member");
  print("Diskon        : $diskon%");
  print("Potongan      : Rp$potongan");
  print("Total Bayar   : Rp${belanja - potongan}");
}
```

## 7. Test Case

| Belanja | Member | Diskon | Potongan | Total Bayar | Aturan |
|---|---|---|---|---|---|
| 80.000 | Tidak | 0% | 0 | 80.000 | BR-01 |
| 150.000 | Tidak | 10% | 15.000 | 135.000 | BR-02 |
| 150.000 | Ya | 15% | 22.500 | 127.500 | BR-03 |
| 300.000 | Ya | 15% | 25.000 (dibatasi dari 45.000) | 275.000 | BR-04 |

> Catatan: karena memakai tipe `double`, Dart menampilkan angka dengan `.0` di belakangnya (misalnya `Rp80000.0`).
