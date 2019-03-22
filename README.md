string_validator
=============

String validation and sanitization for Dart.

The is a new fork of [validator.dart](https://github.com/karan/validator.dart), which was originally a port of [validator.js](https://github.com/chriso/validator.js).

## Usage

#### Documentation

Complete documentation of the package is available at [ADD DOCS]

For a list of methods, refer to the sections below.


## Validators

- **equals(String str, comparison)** - check if the string matches the comparison.
- **contains(String str, seed)** - check if the string contains the seed.
- **matches(String str, pattern)** - check if string matches the pattern. `matches('foobar', 'foo')`.
- **isEmail(String str)** - check if the string is an email.
- **isURL(String str [, options])** - check if the string is an URL. `options` is an object which defaults to `{ protocols: ['http','https','ftp'], require_tld: true, require_protocol: false, allow_underscores: false, host_whitelist: false, host_blacklist: false }`.
- **isFQDN(String str [, options])** - check if the string is a fully qualified domain name (e.g. domain.com). `options` is an object which defaults to `{ require_tld: true, allow_underscores: false }`.
- **isIP(String str [, version])** - check if the string is an IP (version 4 or 6).
- **isAlpha(String str)** - check if the string contains only letters (a-zA-Z).
- **isNumeric(String str)** - check if the string contains only numbers.
- **isAlphanumeric(String str)** - check if the string contains only letters and numbers.
- **isBase64(String str)** - check if a string is base64 encoded.
- **isHexadecimal(String str)** - check if the string is a hexadecimal number.
- **isHexColor(String str)** - check if the string is a hexadecimal color.
- **isLowercase(String str)** - check if the string is lowercase.
- **isUppercase(String str)** - check if the string is uppercase.
- **isInt(String str)** - check if the string is an integer.
- **isFloat(String str)** - check if the string is a float.
- **isDivisibleBy(String str, number)** - check if the string is a number that's divisible by another.
- **isNull(String str)** - check if the string is null.
- **isLength(String str, min [, max])** - check if the string's length falls in a range. Note: this function takes into account surrogate pairs.
- **isByteLength(String str, min [, max])** - check if the string's length (in bytes) falls in a range.
- **isUUID(String str [, version])** - check if the string is a UUID (version 3, 4 or 5).
- **isDate(String str)** - check if the string is a date.
- **isAfter(String str [, date])** - check if the string is a date that's after the specified date (defaults to now).
- **isBefore(String str [, date])** - check if the string is a date that's before the specified date.
- **isIn(String str, values)** - check if the string is in a array of allowed values.
- **isCreditCard(String str)** - check if the string is a credit card.
- **isISBN(String str [, version])** - check if the string is an ISBN (version 10 or 13).
- **isJSON(String str)** - check if the string is valid JSON (note: uses JSON.parse).
- **isMultibyte(String str)** - check if the string contains one or more multibyte chars.
- **isAscii(String str)** - check if the string contains ASCII chars only.
- **isFullWidth(String str)** - check if the string contains any full-width chars.
- **isHalfWidth(String str)** - check if the string contains any half-width chars.
- **isVariableWidth(String str)** - check if the string contains a mixture of full and half-width chars.
- **isSurrogatePair(String str)** - check if the string contains any surrogate pairs chars.
- **isMongoId(String str)** - check if the string is a valid hex-encoded representation of a [MongoDB ObjectId][mongoid].

## Sanitizers

- **toString(String input)** - convert the input to a string.
- **toDate(String input)** - convert the input to a date, or `null` if the input is not a date.
- **toFloat(String input)** - convert the input to a float, or `NaN` if the input is not a float.
- **toInt(String input [, radix])** - convert the input to an integer, or `NaN` if the input is not an integer.
- **toBoolean(String input [, strict])** - convert the input to a boolean. Everything except for `'0'`, `'false'` and `''` returns `true`. In strict mode only `'1'` and `'true'` return `true`.
- **trim(String input [, chars])** - trim characters (whitespace by default) from both sides of the input.
- **ltrim(String input [, chars])** - trim characters from the left-side of the input.
- **rtrim(String input [, chars])** - trim characters from the right-side of the input.
- **escape(String input)** - replace `<`, `>`, `&`, `'` and `"` with HTML entities.
- **stripLow(String input [, keep_new_lines])** - remove characters with a numerical value < 32 and 127, mostly control characters. If `keep_new_lines` is `true`, newline characters are preserved (`\n` and `\r`, hex `0xA` and `0xD`). Unicode-safe in JavaScript.
- **whitelist(String input, chars)** - remove characters that do not appear in the whitelist. The characters are used in a RegExp and so you will need to escape some chars, e.g. whitelist(String input, '\\[\\]').
- **blacklist(String input, chars)** - remove characters that appear in the blacklist. The characters are used in a RegExp and so you will need to escape some chars, e.g. blacklist(String input, '\\[\\]').
- **normalizeEmail(String email [, options])** - canonicalize an email address. `options` is an object which defaults to `{ lowercase: true }`. With `lowercase` set to `true`, the local part of the email address is lowercased for all domains; the hostname is always lowercased and the local part of the email address is always lowercased for hosts that are known to be case-insensitive (currently only GMail). Normalization follows special rules for known providers: currently, GMail addresses have dots removed in the local part and are stripped of tags (e.g. `some.one+tag@gmail.com` becomes `someone@gmail.com`) and all `@googlemail.com` addresses are normalized to `@gmail.com`.

## Tests

To test the package, run:

```
$ pub run test test/test_all.dart
```
