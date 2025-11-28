extension IntExtension on int {
  /// Formats integer into `10 000 UZS` style string.
  String toUZSString() {
    final digits = abs().toString();
    final buffer = StringBuffer();

    for (var i = 0; i < digits.length; i++) {
      if (i != 0 && (digits.length - i) % 3 == 0) {
        buffer.write(' ');
      }
      buffer.write(digits[i]);
    }

    final formatted = this < 0 ? '-${buffer.toString()}' : buffer.toString();
    return '$formatted UZS';
  }
}

