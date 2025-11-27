import 'package:flutter/services.dart';

class MaskedInputFormatter extends TextInputFormatter {
  const MaskedInputFormatter({required this.maskPattern});

  final String maskPattern;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final unmaskedText = newValue.text.replaceAll(RegExp(r'\D'), '');
    final maskedText = applyMask(unmaskedText, maskPattern);

    return TextEditingValue(
      text: maskedText,
      selection: TextSelection.collapsed(offset: maskedText.length),
    );
  }

  String applyMask(String value, String mask) {
    var maskedValue = '';
    var valueIndex = 0;

    for (var i = 0; i < mask.length; i++) {
      if (valueIndex >= value.length) break;

      if (mask[i] == '#') {
        maskedValue += value[valueIndex];
        valueIndex++;
      } else {
        maskedValue += mask[i];
      }
    }

    return maskedValue;
  }
}
