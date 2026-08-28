const List<String> _monthShortNames = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'Mei',
  'Jun',
  'Jul',
  'Agu',
  'Sep',
  'Okt',
  'Nov',
  'Des',
];

String _pad(int value) => value.toString().padLeft(2, '0');

/// `14:05`
String formatClock(DateTime value) => '${_pad(value.hour)}:${_pad(value.minute)}';

/// `14:05:09`
String formatClockWithSecond(DateTime value) =>
    '${_pad(value.hour)}:${_pad(value.minute)}:${_pad(value.second)}';

/// `29 Agu 2026`
String formatDateShort(DateTime value) =>
    '${value.day} ${_monthShortNames[value.month - 1]} ${value.year}';

/// `29 Agu 2026 · 14:05`
String formatDateTimeShort(DateTime value) =>
    '${formatDateShort(value)} · ${formatClock(value)}';

/// Lama pesanan menunggu, dipakai di timer kartu KDS. `3 mnt` / `1 jam 12 mnt`
String formatElapsed(DateTime start, {DateTime? now}) {
  final elapsed = (now ?? DateTime.now()).difference(start);
  if (elapsed.isNegative || elapsed.inMinutes < 1) return 'Baru saja';
  if (elapsed.inMinutes < 60) return '${elapsed.inMinutes} mnt';
  return '${elapsed.inHours} jam ${elapsed.inMinutes % 60} mnt';
}

/// Durasi shift berjalan. `4 jam 20 mnt`
String formatDuration(Duration duration) {
  if (duration.inMinutes < 60) return '${duration.inMinutes} mnt';
  return '${duration.inHours} jam ${duration.inMinutes % 60} mnt';
}
