
string_validator

=============

  

String validation and sanitization for Dart.

  

This is a new fork of [validator.dart](https://github.com/karan/validator.dart), which was originally a port of [validator.js](https://github.com/chriso/validator.js).

  

## Validators

  

-  **equals(String str, comparison)** - check if the string matches the comparison.

-  **contains(String str, seed)** - check if the string contains the seed.

-  **matches(String str, pattern)** - check if string matches the pattern. `matches('foobar', 'foo')`.

-  **isEmail(String str)** - check if the string is an email.

-  **isURL(String str [, options])** - check if the string is an URL. `options` is an object which defaults to `{ protocols: ['http','https','ftp'], require_tld: true, require_protocol: false, allow_underscores: false }`.

-  **isFQDN(String str [, options])** - check if the string is a fully qualified domain name (e.g. domain.com). `options` is an object which defaults to `{ require_tld: true, allow_underscores: false }`.

-  **isIP(String str [, version])** - check if the string is an IP (version 4 or 6).

-  **isAlpha(String str)** - check if the string contains only letters (a-zA-Z).

-  **isNumeric(String str)** - check if the string contains only numbers.

-  **isAlphanumeric(String str)** - check if the string contains only letters and numbers.

-  **isBase64(String str)** - check if a string is base64 encoded.

-  **isHexadecimal(String str)** - check if the string is a hexadecimal number.

-  **isHexColor(String str)** - check if the string is a hexadecimal color.

-  **isLowercase(String str)** - check if the string is lowercase.

-  **isUppercase(String str)** - check if the string is uppercase.

-  **isInt(String str)** - check if the string is an integer.

-  **isFloat(String str)** - check if the string is a float.

-  **isDivisibleBy(String str, number)** - check if the string is a number that's divisible by another.

-  **isLength(String str, min [, max])** - check if the string's length falls in a range. Note: this function takes into account surrogate pairs.

-  **isByteLength(String str, min [, max])** - check if the string's length (in bytes) falls in a range.

-  **isUUID(String str [, version])** - check if the string is a UUID (version 3, 4 or 5).

-  **isDate(String str)** - check if the string is a date.

-  **isAfter(String str [, date])** - check if the string is a date that's after the specified date (defaults to now).

-  **isBefore(String str [, date])** - check if the string is a date that's before the specified date.

-  **isIn(String str, values)** - check if the string is in a array of allowed values.

-  **isCreditCard(String str)** - check if the string is a credit card.

-  **isISBN(String str [, version])** - check if the string is an ISBN (version 10 or 13).

-  **isJSON(String str)** - check if the string is valid JSON (note: uses JSON.parse).

-  **isMultibyte(String str)** - check if the string contains one or more multibyte chars.

-  **isAscii(String str)** - check if the string contains ASCII chars only.

-  **isFullWidth(String str)** - check if the string contains any full-width chars.

-  **isHalfWidth(String str)** - check if the string contains any half-width chars.

-  **isVariableWidth(String str)** - check if the string contains a mixture of full and half-width chars.

-  **isSurrogatePair(String str)** - check if the string contains any surrogate pairs chars.

-  **isMongoId(String str)** - check if the string is a valid hex-encoded representation of a [MongoDB ObjectId][mongoid].

  

## Sanitizers

  

-  **toString(String input)** - convert the input to a string.

-  **toDate(String input)** - convert the input to a date, or `null` if the input is not a date.

-  **toFloat(String input)** - convert the input to a float, or `NaN` if the input is not a float.

-  **toInt(String input [, radix])** - convert the input to an integer, or `NaN` if the input is not an integer.

-  **toBoolean(String input [, strict])** - convert the input to a boolean. Everything except for `'0'`, `'false'` and `''` returns `true`. In strict mode only `'1'` and `'true'` return `true`.

-  **trim(String input [, chars])** - trim characters (whitespace by default) from both sides of the input.

-  **ltrim(String input [, chars])** - trim characters from the left-side of the input.

-  **rtrim(String input [, chars])** - trim characters from the right-side of the input.

-  **escape(String input)** - replace `<`, `>`, `&`, `'` and `"` with HTML entities.

-  **stripLow(String input [, keep_new_lines])** - remove characters with a numerical value < 32 and 127, mostly control characters. If `keep_new_lines` is `true`, newline characters are preserved (`\n` and `\r`, hex `0xA` and `0xD`). Unicode-safe in JavaScript.

-  **whitelist(String input, chars)** - remove characters that do not appear in the whitelist. The characters are used in a RegExp and so you will need to escape some chars, e.g. whitelist(String input, '\\[\\]').

-  **blacklist(String input, chars)** - remove characters that appear in the blacklist. The characters are used in a RegExp and so you will need to escape some chars, e.g. blacklist(String input, '\\[\\]').

-  **normalizeEmail(String email [, options])** - canonicalize an email address. `options` is an object which defaults to `{ lowercase: true }`. With `lowercase` set to `true`, the local part of the email address is lowercased for all domains; the hostname is always lowercased and the local part of the email address is always lowercased for hosts that are known to be case-insensitive (currently only GMail). Normalization follows special rules for known providers: currently, GMail addresses have dots removed in the local part and are stripped of tags (e.g. `some.one+tag@gmail.com` becomes `someone@gmail.com`) and all `@googlemail.com` addresses are normalized to `@gmail.com`.

## Extension Methods

To make using these validators and sanitizers more convenient, this package includes extension methods for each function. These methods can be called directly on a string instance, making the code more concise and readable.

### Example Usage

Here are some examples of how to use the extension methods:

    import 'package:string_validator/string_validator.dart';
    
    void main() {
      // Using Validator Extensions
      String email = 'example@gmail.com';
      bool isEmailValid = email.isEmail;
    
      String url = 'https://example.com';
      bool isUrlValid = url.isURL();
    
      String ip = '192.168.0.1';
      bool isIpValid = ip.isIP();
    
      String alpha = 'abc';
      bool isAlphaValid = alpha.isAlpha;
    
      String numeric = '123';
      bool isNumericValid = numeric.isNumeric;
    
      String alphanumeric = 'abc123';
      bool isAlphanumericValid = alphanumeric.isAlphanumeric;
    
      String base64 = 'aGVsbG8gd29ybGQ=';
      bool isBase64Valid = base64.isBase64;
    
      String integer = '12345';
      bool isIntValid = integer.isInt;
    
      String float = '123.45';
      bool isFloatValid = float.isFloat;
    
      String hex = '1f';
      bool isHexValid = hex.isHexadecimal;
    
      String hexColor = '#ff0000';
      bool isHexColorValid = hexColor.isHexColor;
    
      String lower = 'hello';
      bool isLowerValid = lower.isLowercase;
    
      String upper = 'HELLO';
      bool isUpperValid = upper.isUppercase;
    
      String divisible = '10';
      bool isDivisibleValid = divisible.isDivisibleBy(2);
    
      String length = 'hello';
      bool isLengthValid = length.isLength(3, 6);
    
      String byteLength = 'hello';
      bool isByteLengthValid = byteLength.isByteLength(3, 10);
    
      String uuid = '550e8400-e29b-41d4-a716-446655440000';
      bool isUuidValid = uuid.isUUID();
    
      String date = '2023-05-17';
      bool isDateValid = date.isDate;
    
      String afterDate = '2024-01-01';
      bool isAfterValid = afterDate.isAfter('2023-12-31');
    
      String beforeDate = '2023-01-01';
      bool isBeforeValid = beforeDate.isBefore('2024-01-01');
    
      String inList = 'apple';
      bool isInValid = inList.isIn(['apple', 'banana', 'cherry']);
    
      String creditCard = '4111111111111111';
      bool isCreditCardValid = creditCard.isCreditCard;
    
      String isbn = '978-3-16-148410-0';
      bool isIsbnValid = isbn.isISBN();
    
      String json = '{"name": "John"}';
      bool isJsonValid = json.isJson;
    
      String multibyte = '你好';
      bool isMultibyteValid = multibyte.isMultibyte;
    
      String ascii = 'Hello';
      bool isAsciiValid = ascii.isAscii;
    
      String fullWidth = 'Ｈｅｌｌｏ';
      bool isFullWidthValid = fullWidth.isFullWidth;
    
      String halfWidth = 'Hello';
      bool isHalfWidthValid = halfWidth.isHalfWidth;
    
      String variableWidth = 'Ｈｅllo';
      bool isVariableWidthValid = variableWidth.isVariableWidth;
    
      String surrogatePair = '𐍈';
      bool isSurrogatePairValid = surrogatePair.isSurrogatePair;
    
      String mongoId = '507f1f77bcf86cd799439011';
      bool isMongoIdValid = mongoId.isMongoId;
    
      // Using Sanitizer Extensions
      String dateStr = '2024-05-18';
      DateTime? parsedDate = dateStr.toDate();
    
      String floatStr = '123.45';
      double parsedFloat = floatStr.toFloat();
    
      String intStr = '123';
      int parsedInt = intStr.toInt();
    
      String boolStr = 'true';
      bool parsedBool = boolStr.toBoolean();
    
      String trimStr = '  hello world  ';
      String trimmedStr = trimStr.trim();
    
      String ltrimStr = '  hello';
      String ltrimmedStr = ltrimStr.ltrim();
    
      String rtrimStr = 'hello  ';
      String rtrimmedStr = rtrimStr.rtrim();
    
      String whitelistStr = 'abcdef';
      String whitelistedStr = whitelistStr.whitelist('abc');
    
      String blacklistStr = 'abcdef';
      String blacklistedStr = blacklistStr.blacklist('abc');
    
      String stripLowStr = 'hello\u0000world';
      String strippedLowStr = stripLowStr.stripLow();
    
      String escapeStr = '<div>"Hello"&</div>';
      String escapedStr = escapeStr.escape();
    
      String normalizeEmailStr = 'Example+test@gmail.com';
      String normalizedEmail = normalizeEmailStr.normalizeEmail();
    }

