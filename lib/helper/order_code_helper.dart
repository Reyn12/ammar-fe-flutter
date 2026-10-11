/// Nomor antrean = urutan di belakang kode pesanan ("A261011-021" -> "021").
/// Dapur memanggil pelanggan dengan nomor ini. Kode tanpa strip dikembalikan apa adanya.
String queueNumberOf(String? code) {
  if (code == null || code.isEmpty) return '-';
  final dash = code.lastIndexOf('-');
  return dash < 0 ? code : code.substring(dash + 1);
}
