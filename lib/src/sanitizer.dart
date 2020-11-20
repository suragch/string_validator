import 'helpers.dart';
import 'validator.dart';

Map<String, Object> _default_normalize_email_options = {'lowercase': true};

/// convert the input to a string
String toString(input) {
  if (input == null || (input is List && input.isEmpty)) {
    input = '';
  }
  return input.toString();
}

/// convert the input to a date, or null if the input is not a date
DateTime? toDate(String str) {
  try {
    return DateTime.parse(str);
  } catch (e) {
    return null;
  }
}

/// convert the input to a float, or NAN if the input is not a float
double toFloat(String str) {
  try {
    return double.parse(str);
  } catch (e) {
    return double.nan;
  }
}

/// convert the input to a float, or NAN if the input is not a float
double toDouble(String str) {
  return toFloat(str);
}

/// convert the input to an integer, or NAN if the input is not an integer
num toInt(String str, {int radix = 10}) {
  try {
    return int.parse(str, radix: radix);
  } catch (e) {
    try {
      return double.parse(str).toInt();
    } catch (e) {
      return double.nan;
    }
  }
}

/// convert the input to a boolean.
///
/// Everything except for '0', 'false' and ''
/// returns `true`. In `strict` mode only '1' and 'true' return `true`.
bool toBoolean(String str, [bool strict = false]) {
  if (strict == true) {
    return str == '1' || str == 'true';
  }
  return str != '0' && str != 'false' && str != '';
}

/// trim characters (whitespace by default) from both sides of the input
String trim(String str, [String? chars]) {
  RegExp pattern = (chars != null)
      ? RegExp('^[$chars]+|[$chars]+\$')
      : RegExp(r'^\s+|\s+$');
  return str.replaceAll(pattern, '');
}

/// trim characters from the left-side of the input
String ltrim(String str, [String? chars]) {
  var pattern = chars != null ? RegExp('^[$chars]+') : RegExp(r'^\s+');
  return str.replaceAll(pattern, '');
}

/// trim characters from the right-side of the input
String rtrim(String str, [String? chars]) {
  var pattern = chars != null ? RegExp('[$chars]+\$') : RegExp(r'\s+$');
  return str.replaceAll(pattern, '');
}

/// remove characters that do not appear in the whitelist.
///
/// The characters are used in a RegExp and so you will need to escape
/// some chars.
String whitelist(String str, String chars) {
  return str.replaceAll(RegExp('[^' + chars + ']+'), '');
}

/// remove characters that appear in the blacklist.
///
/// The characters are used in a RegExp and so you will need to escape
/// some chars.
String blacklist(String str, String chars) {
  return str.replaceAll(RegExp('[' + chars + ']+'), '');
}

/// remove characters with a numerical value < 32 and 127.
///
/// If `keep_new_lines` is `true`, newline characters are preserved
/// `(\n and \r, hex 0xA and 0xD)`.
String stripLow(String str, [bool keep_new_lines = false]) {
  String chars = keep_new_lines == true
      ? '\x00-\x09\x0B\x0C\x0E-\x1F\x7F'
      : '\x00-\x1F\x7F';
  return blacklist(str, chars);
}

/// replace `<`, `>`, `&`, `'` and `"` with HTML entities
String escape(String str) {
  return (str
      .replaceAll(RegExp(r'&'), '&amp;')
      .replaceAll(RegExp(r'"'), '&quot;')
      .replaceAll(RegExp(r"'"), '&#x27;')
      .replaceAll(RegExp(r'<'), '&lt;')
      .replaceAll(RegExp(r'>'), '&gt;'));
}

/// canonicalize an email address.
///
/// `options` is a `Map` which defaults to
/// `{ lowercase: true }`. With lowercase set to true, the local part of the
/// email address is lowercased for all domains; the hostname is always
/// lowercased and the local part of the email address is always lowercased
/// for hosts that are known to be case-insensitive (currently only GMail).
/// Normalization follows special rules for known providers: currently,
/// GMail addresses have dots removed in the local part and are stripped of
/// tags (e.g. `some.one+tag@gmail.com` becomes `someone@gmail.com`) and all
/// `@googlemail.com` addresses are normalized to `@gmail.com`.
String normalizeEmail(String email, [Map<String, Object>? options]) {
  options = merge(options, _default_normalize_email_options);
  if (isEmail(email) == false) {
    return '';
  }

  List parts = email.split('@');
  parts[1] = parts[1].toLowerCase();

  if (options['lowercase'] == true) {
    parts[0] = parts[0].toLowerCase();
  }

  if (parts[1] == 'gmail.com' || parts[1] == 'googlemail.com') {
    if (options['lowercase'] == false) {
      parts[0] = parts[0].toLowerCase();
    }
    parts[0] = parts[0].replaceAll('\.', '').split('+')[0];
    parts[1] = 'gmail.com';
  }
  return parts.join('@');
}
