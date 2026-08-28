extension StringNullExtension on String? {
  bool get isNotNullAndNotEmpty {
    return this != null && this != '' && this != 'null';
  }

  String? get orNull => (this == 'null' || (this ?? '').isEmpty) ? null : this;

  String? get toPlus62Phone {
    final value = this?.trim();
    if (value == null || value.isEmpty) return value;

    if (value.startsWith('+628')) {
      return value;
    } else if (value.startsWith('628')) {
      return '+$value';
    } else if (value.startsWith('08')) {
      return '+62${value.substring(1)}';
    } else if (value.startsWith('8')) {
      return '+62$value';
    }

    return value;
  }

  String? get to628Phone {
    if (toString().startsWith('08')) {
      return toString().replaceRange(0, 1, '62').trimRight();
    } else if (toString().startsWith('8')) {
      return '62${this?.trimRight()}';
    } else if (toString().startsWith('+628')) {
      return toString().replaceRange(0, 2, '6').trimRight();
    } else {
      return this;
    }
  }

  String? get to8Phone {
    final value = this?.trim();
    if (value == null || value.isEmpty) return value;

    if (value.startsWith('+628')) {
      return value.substring(3);
    } else if (value.startsWith('628')) {
      return value.substring(2);
    } else if (value.startsWith('08')) {
      return value.substring(1);
    } else if (value.startsWith('8')) {
      return value;
    }

    return value;
  }

  bool get isHtml {
    final htmlTagRegex = RegExp(
      r'</?(html|body|div|span|p|a|img|br|ul|ol|li|table|tr|td|th|b|i|u|strong|em)[^>]*>',
      caseSensitive: false,
    );
    return htmlTagRegex.hasMatch(this ?? '');
  }
}
