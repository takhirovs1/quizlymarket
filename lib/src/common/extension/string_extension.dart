/// [StringX]
extension StringX on String {
  /// Extension to check whether given string is digit
  bool get isDigit => BigInt.tryParse(this) != null;
  bool get isDouble => double.tryParse(this) != null;

  String get capitalize {
    try {
      return this[0].toUpperCase() + substring(1).toLowerCase();
    } on Object catch (_) {
      return '';
    }
  }

  String ellipsis([int len = 10, bool showDot = true]) =>
      length > len ? '${substring(0, len)}${showDot ? '...' : ''} ' : this;

  String ellipsisOrSpace([int len = 10]) {
    if (length > len) {
      return '${substring(0, len)}...';
    } else {
      return this + (' ' * (len - length));
    }
  }
}
