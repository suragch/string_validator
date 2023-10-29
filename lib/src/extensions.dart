import 'validator.dart' as v;

extension ValdatorExtension on String {
  /// check if the string matches the comparison
  bool equals(Object? comparison) => v.equals(this, comparison);

  /// check if string matches the pattern.
  bool matches(String pattern) => v.matches(this, pattern);

  /// check if the string is an email
  bool isEmail() => v.isEmail(this);

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
  bool isAlpha() => v.isAlpha(this);

  /// check if the string contains only numbers
  bool isNumeric() => v.isNumeric(this);

  /// check if the string contains only letters and numbers
  bool isAlphanumeric() => v.isAlphanumeric(this);

  /// check if a string is base64 encoded
  bool isBase64() => v.isBase64(this);

  /// check if the string is an integer
  bool isInt() => v.isInt(this);

  /// check if the string is a float
  bool isFloat() => v.isFloat(this);

  /// check if the string is a hexadecimal number
  bool isHexadecimal() => v.isHexadecimal(this);

  /// check if the string is a hexadecimal color
  bool isHexColor() => v.isHexColor(this);

  /// check if the string is lowercase
  bool isLowercase() => v.isLowercase(this);

  /// check if the string is uppercase
  bool isUppercase() => v.isUppercase(this);

  /// check if the string is a number that's divisible by another
  ///
  /// [n] is a String or an int.
  bool isDivisibleBy(Object n) => v.isDivisibleBy(this, n);

  /// check if the string's length falls in a range
  /// If no max is given then any length above min is ok.
  ///
  /// Note: this function takes into account surrogate pairs.
  bool isLength(int min, [int? max]) => v.isLength(this, min);

  /// check if the string's length (in bytes) falls in a range.
  bool isByteLength(int min, [int? max]) => v.isByteLength(this, min, max);

  /// check if the string is a UUID (version 3, 4 or 5).
  bool isUUID([Object? version]) => v.isUUID(this, version);

  /// check if the string is a date
  bool isDate() => v.isDate(this);

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
  bool isCreditCard() => v.isCreditCard(this);

  /// check if the string is an ISBN (version 10 or 13)
  bool isISBN([Object? version]) => v.isISBN(this, version);

  /// check if the string is valid JSON
  bool isJson() => v.isJson(this);

  /// check if the string contains one or more multibyte chars
  bool isMultibyte() => v.isMultibyte(this);

  /// check if the string contains ASCII chars only
  bool isAscii() => v.isAscii(this);

  /// check if the string contains any full-width chars
  bool isFullWidth() => v.isFullWidth(this);

  /// check if the string contains any half-width chars
  bool isHalfWidth() => v.isHalfWidth(this);

  /// check if the string contains a mixture of full and half-width chars
  bool isVariableWidth() => v.isVariableWidth(this);

  /// check if the string contains any surrogate pairs chars
  bool isSurrogatePair() => v.isSurrogatePair(this);

  /// check if the string is a valid hex-encoded representation of a MongoDB ObjectId
  bool isMongoId() => v.isMongoId(this);
}
