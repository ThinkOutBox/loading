void main() {
  final now = DateTime.now();
  print(now.formatYMDHM());
  // Implement an extension on [DateTime], returning a [String] in format of
  // `YYYY.MM.DD hh:mm:ss` (e.g. `2023.01.01 00:00:00`).
}

extenstion FormatDateTime on DateTime {
  String formatYMDHM() {
    String twoDigits(int n) => n.toString().padLeft(2,'0');

    final year = this.year;
    final month = twoDigits(this.month);
    final day = twoDigits(this.day);
    final hour = twoDigits(this.hour);
    final minute = twoDigits(this.minute);

    return '$year.$month.$day.$hour.$minute';
  }
}
