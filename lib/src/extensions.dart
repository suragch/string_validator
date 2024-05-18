import 'validator.dart' as v;
import 'helpers.dart';

extension ValidatorExtensions on String {
  /// check if the string matches the comparison
  bool equals(Object? comparison) => v.equals(this, comparison);

  /// check if string matches the pattern.
  bool matches(String pattern) => v.matches(this, pattern);

  /// check if the string is an email
  bool get isEmail => v.isEmail(this);

  /// check if the string is a URL
  ///
  /// `options` is a `Map` which defaults to
  /// `{ 'protocols': ['http','https','ftp'], 'require_tld': true,
  /// 'require_protocol': false, 'allow_underscores': false }`.
  bool isURL([Map<String, Object>? options]) => v.isURL(this, options);

  /// check if the string is an IP (version 4 or 6)
  ///
  /// `version` is a String or an `int`.
  bool isIP([Object? version]) => v.isIP(this, version);

  /// check if the string is a fully qualified domain name (e.g. domain.com).
  ///
  /// `options` is a `Map` which defaults to `{ 'require_tld': true, 'allow_underscores': false }`.
  bool isFQDN([Map<String, Object>? options]) => v.isFQDN(this, options);

  /// check if the string contains only letters (a-zA-Z).
  bool get isAlpha => v.isAlpha(this);

  /// check if the string contains only numbers
  bool get isNumeric => v.isNumeric(this);

  /// check if the string contains only letters and numbers
  bool get isAlphanumeric => v.isAlphanumeric(this);

  /// check if a string is base64 encoded
  bool get isBase64 => v.isBase64(this);

  /// check if the string is an integer
  bool get isInt => v.isInt(this);

  /// check if the string is a float
  bool get isFloat => v.isFloat(this);

  /// check if the string is a hexadecimal number
  bool get isHexadecimal => v.isHexadecimal(this);

  /// check if the string is a hexadecimal color
  bool get isHexColor => v.isHexColor(this);

  /// check if the string is lowercase
  bool get isLowercase => v.isLowercase(this);

  /// check if the string is uppercase
  bool get isUppercase => v.isUppercase(this);

  /// check if the string is a number that's divisible by another
  ///
  /// [n] is a String or an int.
  bool isDivisibleBy(Object n) => v.isDivisibleBy(this, n);

  /// check if the string's length falls in a range
  /// If no max is given then any length above min is ok.
  ///
  /// Note: this function takes into account surrogate pairs.
  bool isLength(int min, [int? max]) => v.isLength(this, min, max);

  /// check if the string's length (in bytes) falls in a range.
  bool isByteLength(int min, [int? max]) => v.isByteLength(this, min, max);

  /// check if the string is a UUID (version 3, 4 or 5).
  bool isUUID([Object? version]) => v.isUUID(this, version);

  /// check if the string is a date
  bool get isDate => v.isDate(this);

  /// check if the string is a date that's after the specified date
  ///
  /// If `date` is not passed, it defaults to now.
  bool isAfter([String? date]) => v.isAfter(this, date);

  /// check if the string is a date that's before the specified date
  ///
  /// If `date` is not passed, it defaults to now.
  bool isBefore([String? date]) => v.isBefore(this, date);

  /// check if the string is in an array of allowed values
  bool isIn(Object? values) => v.isIn(this, values);

  /// check if the string is a credit card
  bool get isCreditCard => v.isCreditCard(this);

  /// check if the string is an ISBN (version 10 or 13)
  bool isISBN([Object? version]) => v.isISBN(this, version);

  /// check if the string is valid JSON
  bool get isJson => v.isJson(this);

  /// check if the string contains one or more multibyte chars
  bool get isMultibyte => v.isMultibyte(this);

  /// check if the string contains ASCII chars only
  bool get isAscii => v.isAscii(this);

  /// check if the string contains any full-width chars
  bool get isFullWidth => v.isFullWidth(this);

  /// check if the string contains any half-width chars
  bool get isHalfWidth => v.isHalfWidth(this);

  /// check if the string contains a mixture of full and half-width chars
  bool get isVariableWidth => v.isVariableWidth(this);

  /// check if the string contains any surrogate pairs chars
  bool get isSurrogatePair => v.isSurrogatePair(this);

  /// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
  bool get isMongoId => v.isMongoId(this);
}

extension SanitizerExtensions on String {
  /// Converts the string to a [DateTime] object. Returns null if parsing fails.
  DateTime? toDate() => DateTime.tryParse(this);

  /// Converts the string to a [double]. Returns NaN if parsing fails.
  double toFloat() => double.tryParse(this) ?? double.nan;

  /// Converts the string to a [double]. Returns NaN if parsing fails.
  double toDouble() => toFloat();

  /// Converts the string to a [num]. [radix] is the base for integer parsing.
  num toInt({int radix = 10}) =>
      int.tryParse(this, radix: radix) ??
      double.tryParse(this)?.toInt() ??
      double.nan;

  /// Converts the string to a [bool]. [strict] mode only allows '1' and 'true' to return true.
  bool toBoolean([bool strict = false]) => strict == true
      ? this == '1' || this == 'true'
      : this != '0' && this != 'false' && isNotEmpty;

  /// Trims characters from the left side of the string.
  String ltrim([String? chars]) => (chars != null)
      ? replaceAll(RegExp('^[$chars]+'), '')
      : replaceAll(RegExp(r'^\s+'), '');

  /// Trims characters from the right side of the string.
  String rtrim([String? chars]) => (chars != null)
      ? replaceAll(RegExp('[$chars]+\$'), '')
      : replaceAll(RegExp(r'\s+$'), '');

  /// Removes characters that do not appear in the whitelist.
  String whitelist(String chars) => replaceAll(RegExp('[^$chars]+'), '');

  /// Removes characters that appear in the blacklist.
  String blacklist(String chars) => replaceAll(RegExp('[$chars]+'), '');

  /// Removes characters with a numerical value less than 32 and 127.
  /// If [keepNewLines] is true, newline characters are preserved (\n and \r, hex 0xA and 0xD).
  String stripLow([bool keepNewLines = false]) {
    final chars = keepNewLines == true
        ? '\x00-\x09\x0B\x0C\x0E-\x1F\x7F'
        : '\x00-\x1F\x7F';
    return blacklist(chars);
  }

  /// Replaces HTML entities <, >, &, ', and " with their respective HTML entities.
  String escape() => replaceAll(RegExp(r'&'), '&amp;')
      .replaceAll(RegExp(r'"'), '&quot;')
      .replaceAll(RegExp(r"'"), '&#x27;')
      .replaceAll(RegExp(r'<'), '&lt;')
      .replaceAll(RegExp(r'>'), '&gt;');

  /// Canonicalizes an email address. Options include lowercase and specific provider rules.
  String normalizeEmail([Map<String, Object>? options]) {
    Map<String, Object> defaultNormalizeEmailOptions = {'lowercase': true};
    options = merge(options, defaultNormalizeEmailOptions);
    if (isEmail == false) {
      return '';
    }

    final parts = split('@');
    parts[1] = parts[1].toLowerCase();

    if (options['lowercase'] == true) {
      parts[0] = parts[0].toLowerCase();
    }

    if (parts[1] == 'gmail.com' || parts[1] == 'googlemail.com') {
      if (options['lowercase'] == false) {
        parts[0] = parts[0].toLowerCase();
      }
      parts[0] = parts[0].replaceAll('.', '').split('+')[0];
      parts[1] = 'gmail.com';
    }
    return parts.join('@');
  }
}
