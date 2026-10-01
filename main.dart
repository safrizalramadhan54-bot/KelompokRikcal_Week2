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