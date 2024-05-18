import 'package:test/test.dart';
import 'package:string_validator/src/extensions.dart';

void main() {
  test('strings are equal', () {
    // valid
    expect('abc'.equals('abc'), equals(true));
    // invalid
    expect('abc'.equals('Abc'), equals(false));
    expect('abc'.equals('123'), equals(false));
    expect('abc'.equals(null), equals(false));
  });

  test('strings contains substring', () {
    // valid
    expect('foo'.contains('foo'), equals(true));
    expect('foobar'.contains('foo'), equals(true));
    expect('bazfoo'.contains('foo'), equals(true));
    // invalid
    expect('Foo'.contains('foo'), equals(false));
    expect('bar'.contains('foo'), equals(false));
  });

  test('strings has matching pattern', () {
    // valid
    expect('abc'.matches('abc'), equals(true));
    expect('abcdef'.matches('abc'), equals(true));
    expect('123abc'.matches('abc'), equals(true));
    // invalid
    expect('acb'.matches('abc'), equals(false));
    expect('ABC'.matches('abc'), equals(false));
  });

  test('strings is email', () {
    // valid
    expect('foo@bar.com'.isEmail, equals(true));
    expect('x@x.x'.isEmail, equals(true));
    expect('foo@bar.com.au'.isEmail, equals(true));
    expect('foo+bar@bar.com'.isEmail, equals(true));
    expect('hans.m端ller@test.com'.isEmail, equals(true));
    expect('hans@m端ller.com'.isEmail, equals(true));
    expect('test|123@m端ller.com'.isEmail, equals(true));
    expect('test+ext@gmail.com'.isEmail, equals(true));
    expect('some.name.midd.leNa.me.+extension@GoogleMail.com'.isEmail,
        equals(true));
    // invalid
    expect('invalidemail@'.isEmail, equals(false));
    expect('invalid.com'.isEmail, equals(false));
    expect('@invalid.com'.isEmail, equals(false));
    expect('foo@bar.com.'.isEmail, equals(false));
    expect('foo@bar.co.uk.'.isEmail, equals(false));
  });

  test('strings is valid url', () {
    // valid
    expect('foobar.com'.isURL(), equals(true));
    expect('www.foobar.com'.isURL(), equals(true));
    expect('foobar.com/'.isURL(), equals(true));
    expect('valid.au'.isURL(), equals(true));
    expect('http://www.foobar.com/'.isURL(), equals(true));
    expect('http://www.foobar.com:23/'.isURL(), equals(true));
    expect('http://www.foobar.com:65535/'.isURL(), equals(true));
    expect('http://www.foobar.com:5/'.isURL(), equals(true));
    expect('https://www.foobar.com/'.isURL(), equals(true));
    expect('ftp://www.foobar.com/'.isURL(), equals(true));
    expect('http://www.foobar.com/~foobar'.isURL(), equals(true));
    expect('http://user:pass@www.foobar.com/'.isURL(), equals(true));
    expect('http://127.0.0.1/'.isURL(), equals(true));
    expect('http://10.0.0.0/'.isURL(), equals(true));
    expect('http://189.123.14.13/'.isURL(), equals(true));
    expect('http://duckduckgo.com/?q=%2F'.isURL(), equals(true));
    expect('http://foobar.com/t\$-_.+!*\'(),'.isURL(), equals(true));
    expect('http://localhost:3000/'.isURL(), equals(true));
    expect('http://foobar.com/?foo=bar#baz=qux'.isURL(), equals(true));
    expect('http://foobar.com?foo=bar'.isURL(), equals(true));
    expect('http://foobar.com#baz=qux'.isURL(), equals(true));
    expect('http://www.xn--froschgrn-x9a.net/'.isURL(), equals(true));
    expect('http://xn--froschgrn-x9a.com/'.isURL(), equals(true));
    expect('http://foo--bar.com'.isURL(), equals(true));
    expect('http://username:token@example.com/protected/files'.isURL(),
        equals(true));
    // invalid
    expect('xyz://foobar.com'.isURL(), equals(false));
    expect('invalid/'.isURL(), equals(false));
    expect('invalid.x'.isURL(), equals(false));
    expect('invalid.'.isURL(), equals(false));
    expect('.com'.isURL(), equals(false));
    expect('http://com/'.isURL(), equals(false));
    expect('http://300.0.0.1/'.isURL(), equals(false));
    expect('mailto:foo@bar.com'.isURL(), equals(false));
    expect('rtmp://foobar.com'.isURL(), equals(false));
    expect('http://www.xn--.com/'.isURL(), equals(false));
    expect('http://xn--.com/'.isURL(), equals(false));
    expect('http://www.foobar.com:0/'.isURL(), equals(false));
    expect('http://www.foobar.com:70000/'.isURL(), equals(false));
    expect('http://www.foobar.com:99999/'.isURL(), equals(false));
    expect('http://www.-foobar.com/'.isURL(), equals(false));
    expect('http://www.foobar-.com/'.isURL(), equals(false));
    expect('http://www.foo---bar.com/'.isURL(), equals(false));
    expect('http://www.foo_bar.com/'.isURL(), equals(false));
    expect(''.isURL(), equals(false));
    expect('http://foobar.com/${'f' * 2083}'.isURL(), equals(false));
    expect('http://*.foo.com'.isURL(), equals(false));
    expect('*.foo.com'.isURL(), equals(false));
    expect('!.foo.com'.isURL(), equals(false));
    expect('http://localhost:61500this is an invalid url!!!!'.isURL(),
        equals(false));
  });

  test('strings is valid IP', () {
    // valid
    expect('127.0.0.1'.isIP(), equals(true));
    expect('0.0.0.0'.isIP(), equals(true));
    expect('255.255.255.255'.isIP(), equals(true));
    expect('1.2.3.4'.isIP(), equals(true));
    expect('::1'.isIP(), equals(true));
    expect('2001:db8:0000:1:1:1:1:1'.isIP(), equals(true));
    // invalid
    expect('abc'.isIP(), equals(false));
    expect('256.0.0.0'.isIP(), equals(false));
    expect('0.0.0.256'.isIP(), equals(false));
    expect('26.0.0.256'.isIP(), equals(false));
  });

  test('strings contains only letters (a-zA-Z)', () {
    // valid
    expect('abc'.isAlpha, equals(true));
    expect('ABC'.isAlpha, equals(true));
    expect('FoObAr'.isAlpha, equals(true));
    // invalid
    expect('abc1'.isAlpha, equals(false));
    expect('AB  C'.isAlpha, equals(false));
    expect(''.isAlpha, equals(false));
  });

  test('string contains only letters and numbers', () {
    // valid
    expect('abc1'.isAlphanumeric, equals(true));
    expect('0A1BC'.isAlphanumeric, equals(true));
    expect('Fo0bAr'.isAlphanumeric, equals(true));
    // invalid
    expect('abc!'.isAlphanumeric, equals(false));
    expect('AB C'.isAlphanumeric, equals(false));
    expect(''.isAlphanumeric, equals(false));
  });

  test('string contains only numbers', () {
    // valid
    expect('-1'.isNumeric, equals(true));
    expect('0'.isNumeric, equals(true));
    expect('00'.isNumeric, equals(true));
    expect('01'.isNumeric, equals(true));
    expect('19934'.isNumeric, equals(true));
    expect('-23412'.isNumeric, equals(true));
    // invalid
    expect('abc!'.isNumeric, equals(false));
    expect('AB C'.isNumeric, equals(false));
    expect(''.isNumeric, equals(false));
    expect('1.2'.isNumeric, equals(false));
  });

  test('string contains only numbers', () {
    // valid
    expect(
        'TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4='
            .isBase64,
        equals(true));
    expect('Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg=='.isBase64,
        equals(true));
    expect('U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw=='.isBase64, equals(true));
    expect(
        'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNwUAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0YerhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5TkukhxQmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZFwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZHQIDAQAB'
            .isBase64,
        equals(true));
    // invalid
    expect('abc!'.isBase64, equals(false));
    expect('AB C'.isBase64, equals(false));
    expect('Vml2YW11cyBmZXJtZtesting123'.isBase64, equals(false));
    expect(''.isBase64, equals(false));
  });

  test('string is an integer', () {
    // valid
    expect('-1'.isInt, equals(true));
    expect('0'.isInt, equals(true));
    expect('10'.isInt, equals(true));
    expect('23423'.isInt, equals(true));
    expect('19934'.isInt, equals(true));
    expect('-23412'.isInt, equals(true));
    // invalid
    expect('-01'.isInt, equals(false));
    expect('000'.isInt, equals(false));
    expect('12.13'.isInt, equals(false));
    expect('AB'.isInt, equals(false));
    expect(''.isInt, equals(false));
  });

  test('string is a float', () {
    // valid
    expect('-1.324'.isFloat, equals(true));
    expect('0.32'.isFloat, equals(true));
    expect('-0.324'.isFloat, equals(true));
    expect('2423.234234'.isFloat, equals(true));
    expect('-0.22250738585072011e-307'.isFloat, equals(true));
    expect('0.22250738585072011e-307'.isFloat, equals(true));
    // invalid
    expect('abc!'.isFloat, equals(false));
    expect('AB C'.isFloat, equals(false));
    expect(' '.isFloat, equals(false));
  });

  test('string is a hexadecimal number', () {
    // valid
    expect('deadBEEF'.isHexadecimal, equals(true));
    expect('ff0044'.isHexadecimal, equals(true));
    // invalid
    expect('abcdefg'.isHexadecimal, equals(false));
    expect(' '.isHexadecimal, equals(false));
    expect('..'.isHexadecimal, equals(false));
  });

  test('string is a hexadecimal color', () {
    // valid
    expect('#ff0034'.isHexColor, equals(true));
    expect('#CCCCCC'.isHexColor, equals(true));
    expect('fff'.isHexColor, equals(true));
    expect('#f00'.isHexColor, equals(true));
    // invalid
    expect('#ff'.isHexColor, equals(false));
    expect('fff0'.isHexColor, equals(false));
    expect('#ff12FG'.isHexColor, equals(false));
  });

  test('string is lowercase', () {
    // valid
    expect('abc'.isLowercase, equals(true));
    expect('abc123'.isLowercase, equals(true));
    expect('l.o.w.e.r.'.isLowercase, equals(true));
    expect('tr竪s 端ber'.isLowercase, equals(true));
    // invalid
    expect('f00Bar'.isLowercase, equals(false));
    expect('uUu'.isLowercase, equals(false));
  });

  test('string is uppercase', () {
    // valid
    expect('ABC'.isUppercase, equals(true));
    expect('ABC123'.isUppercase, equals(true));
    expect('U.P.P.E.R.'.isUppercase, equals(true));
    // invalid
    expect('f00Bar'.isUppercase, equals(false));
    expect('uUu'.isUppercase, equals(false));
  });

  test('string is a number that\'s divisible by another', () {
    // valid
    expect('2'.isDivisibleBy('2'), equals(true));
    expect('4'.isDivisibleBy('2'), equals(true));
    expect('100'.isDivisibleBy('2'), equals(true));
    expect('-10'.isDivisibleBy('2'), equals(true));
    // invalid
    expect('1'.isDivisibleBy('2'), equals(false));
    expect('-1'.isDivisibleBy('2'), equals(false));
    expect('abc'.isDivisibleBy('2'), equals(false));
  });

  test('length at least', () {
    // valid
    expect('ab'.isLength(2), equals(true));
    expect('de'.isLength(2), equals(true));
    expect('abcd'.isLength(2), equals(true));
    expect('干𩸽'.isLength(2), equals(true));
    // invalid
    expect(''.isLength(2), equals(false));
    expect('a'.isLength(2), equals(false));
    expect('𠀋'.isLength(2), equals(false));
  });

  test('length in range', () {
    // valid
    expect('abc'.isLength(2, 3), equals(true));
    expect('de'.isLength(2, 3), equals(true));
    expect('干𩸽'.isLength(2, 3), equals(true));
    // invalid
    expect(''.isLength(2, 3), equals(false));
    expect('𠀋'.isLength(2, 3), equals(false));
    expect('千竈通り'.isLength(2, 3), equals(false));
  });

  test('byte length at least', () {
    // valid
    expect('ab'.isByteLength(2), equals(true));
    expect('de'.isByteLength(2), equals(true));
    expect('abcd'.isByteLength(2), equals(true));
    expect('干𩸽'.isByteLength(2), equals(true));
    expect('𠀋'.isByteLength(2), equals(true));
    // invalid
    expect(''.isByteLength(2), equals(false));
    expect('a'.isByteLength(2), equals(false));
  });

  test('byte length in range', () {
    // valid
    expect('abc'.isByteLength(2, 3), equals(true));
    expect('de'.isByteLength(2, 3), equals(true));
    expect('干𩸽'.isByteLength(2, 3), equals(true));
    expect('𠀋'.isByteLength(2, 3), equals(true));
    // invalid
    expect(''.isByteLength(2, 3), equals(false));
    expect('千竈通り'.isByteLength(2, 3), equals(false));
  });

  test('string is a UUID (version 3, 4 or 5)', () {
    // valid
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(), equals(true));
    expect('A987FBC9-4BED-4078-8F07-9141BA07C9F3'.isUUID(), equals(true));
    expect('A987FBC9-4BED-5078-AF07-9141BA07C9F3'.isUUID(), equals(true));
    // invalid
    expect(''.isUUID(), equals(false));
    expect('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(), equals(false));
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx'.isUUID(), equals(false));
    expect('A987FBC94BED3078CF079141BA07C9F3'.isUUID(), equals(false));
    expect('934859'.isUUID(), equals(false));
    expect('987FBC9-4BED-3078-CF07A-9141BA07C9F3'.isUUID(), equals(false));
    expect('AAAAAAAA-1111-1111-AAAG-111111111111'.isUUID(), equals(false));
  });

  test('string is a UUID version 3', () {
    // valid
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(3), equals(true));
    // invalid
    expect(''.isUUID(3), equals(false));
    expect('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(3), equals(false));
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx'.isUUID(3), equals(false));
    expect('A987FBC94BED3078CF079141BA07C9F3'.isUUID(3), equals(false));
    expect('934859'.isUUID(3), equals(false));
    expect('987FBC9-4BED-3078-CF07A-9141BA07C9F3'.isUUID(3), equals(false));
    expect('AAAAAAAA-1111-1111-AAAG-111111111111'.isUUID(3), equals(false));
  });

  test('string is a UUID version 4', () {
    // valid
    expect('713ae7e3-cb32-45f9-adcb-7c4fa86b90c1'.isUUID(4), equals(true));
    expect('625e63f3-58f5-40b7-83a1-a72ad31acffb'.isUUID(4), equals(true));
    expect('57b73598-8764-4ad0-a76a-679bb6640eb1'.isUUID(4), equals(true));
    // invalid
    expect(''.isUUID(4), equals(false));
    expect('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(4), equals(false));
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx'.isUUID(4), equals(false));
    expect('A987FBC94BED3078CF079141BA07C9F3'.isUUID(4), equals(false));
    expect('934859'.isUUID(4), equals(false));
    expect('987FBC9-4BED-3078-CF07A-9141BA07C9F3'.isUUID(4), equals(false));
    expect('AAAAAAAA-1111-1111-AAAG-111111111111'.isUUID(4), equals(false));
  });

  test('string is a UUID version 5', () {
    // valid
    expect('987FBC97-4BED-5078-AF07-9141BA07C9F3'.isUUID(5), equals(true));
    expect('987FBC97-4BED-5078-BF07-9141BA07C9F3'.isUUID(5), equals(true));
    expect('987FBC97-4BED-5078-8F07-9141BA07C9F3'.isUUID(5), equals(true));
    // invalid
    expect(''.isUUID(5), equals(false));
    expect('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3'.isUUID(5), equals(false));
    expect('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx'.isUUID(5), equals(false));
    expect('A987FBC94BED3078CF079141BA07C9F3'.isUUID(5), equals(false));
    expect('934859'.isUUID(5), equals(false));
    expect('987FBC9-4BED-3078-CF07A-9141BA07C9F3'.isUUID(5), equals(false));
    expect('AAAAAAAA-1111-1111-AAAG-111111111111'.isUUID(5), equals(false));
  });

  test('string is a date', () {
    // valid
    expect('2012-02-27 13:27:00'.isDate, equals(true));
    expect('2012-02-27'.isDate, equals(true));
    expect('2011-08-04 12:00'.isDate, equals(true));
    expect('2012-02-27 13:27:00.123456z'.isDate, equals(true));
    expect('20120227'.isDate, equals(true));
    expect('2002-02-27T14:00:00-0500'.isDate, equals(true));
    expect('2002-02-27T19:00:00Z'.isDate, equals(true));
    // invalid
    expect(''.isDate, equals(false));
    expect('aaaafff'.isDate, equals(false));
    expect('ABC'.isDate, equals(false));
  });

  test('string is a date after the specified date', () {
    // valid
    expect('2012-12-12'.isAfter('2005-12-12'), equals(true));
    expect('2012-02-27 13:27:00'.isAfter('2005-12-12'), equals(true));
    expect('2022-02-27T14:00:00-0500'.isAfter('2005-12-12'), equals(true));
    // invalid
    expect('2002-12-12'.isAfter('2005-12-12'), equals(false));
    expect('2002-02-27 13:27:00'.isAfter('2005-12-12'), equals(false));
    expect('2002-02-27T14:00:00-0500'.isAfter('2005-12-12'), equals(false));
    expect(' '.isAfter('2005-12-12'), equals(false));
    expect(''.isAfter('2005-12-12'), equals(false));
  });

  test('string is a date after now', () {
    // valid
    expect('2032-12-12'.isAfter(), equals(true));
    expect('2032-02-27 13:27:00'.isAfter(), equals(true));
    expect('2032-02-27T14:00:00-0500'.isAfter(), equals(true));
    // invalid
    expect('2002-12-12'.isAfter(), equals(false));
    expect('2002-02-27 13:27:00'.isAfter(), equals(false));
    expect('2002-02-27T14:00:00-0500'.isAfter(), equals(false));
    expect(' '.isAfter(), equals(false));
    expect(''.isAfter(), equals(false));
  });

  test('string is a date before the specified date', () {
    // valid
    expect('2002-12-12'.isBefore('2005-12-12'), equals(true));
    expect('2002-02-27 13:27:00'.isBefore('2005-12-12'), equals(true));
    expect('2002-02-27T14:00:00-0500'.isBefore('2005-12-12'), equals(true));
    // invalid
    expect('2022-12-12'.isBefore('2005-12-12'), equals(false));
    expect('2022-02-27 13:27:00'.isBefore('2005-12-12'), equals(false));
    expect('2022-02-27T14:00:00-0500'.isBefore('2005-12-12'), equals(false));
    expect(' '.isBefore('2005-12-12'), equals(false));
    expect(''.isBefore('2005-12-12'), equals(false));
  });

  test('string is a date before now', () {
    // valid
    expect('2012-12-12'.isBefore(), equals(true));
    expect('2012-02-27 13:27:00'.isBefore(), equals(true));
    expect('2012-02-27T14:00:00-0500'.isBefore(), equals(true));
    // invalid
    expect('2032-12-12'.isBefore(), equals(false));
    expect('2032-02-27 13:27:00'.isBefore(), equals(false));
    expect('2032-02-27T14:00:00-0500'.isBefore(), equals(false));
    expect(' '.isBefore(), equals(false));
    expect(''.isBefore(), equals(false));
  });

  test('string is in bigger string', () {
    // valid
    expect('foo'.isIn('foobar'), equals(true));
    expect('bar'.isIn('foobar'), equals(true));
    expect('oba'.isIn('foobar'), equals(true));
    expect('foobar'.isIn('foobar'), equals(true));
    expect(''.isIn('foobar'), equals(true));
    // invalid
    expect('1'.isIn('foobar'), equals(false));
    expect(' '.isIn('foobar'), equals(false));
  });

  test('string is in an array of allowed values', () {
    // valid
    expect('1'.isIn([1, 2, 3]), equals(true));
    expect('2'.isIn([1, 2, 3]), equals(true));
    expect('3'.isIn([1, 2, 3]), equals(true));
    // invalid
    expect('4'.isIn([1, 2, 3]), equals(false));
    expect(' '.isIn([1, 2, 3]), equals(false));
  });

  test('string is a credit card number', () {
    // valid
    expect('375556917985515'.isCreditCard, equals(true));
    expect('36050234196908'.isCreditCard, equals(true));
    expect('4716461583322103'.isCreditCard, equals(true));
    expect('4716-2210-5188-5662'.isCreditCard, equals(true));
    expect('4929 7226 5379 7141'.isCreditCard, equals(true));
    expect('5398228707871527'.isCreditCard, equals(true));
    // invalid
    expect('5398228707871528'.isCreditCard, equals(false));
    expect(''.isCreditCard, equals(false));
    expect('Lol0'.isCreditCard, equals(false));
  });

  test('string is an ISBN version 10', () {
    // valid
    expect('3836221195'.isISBN(10), equals(true));
    expect('1617290858'.isISBN(10), equals(true));
    expect('0007269706'.isISBN(10), equals(true));
    expect('3423214120'.isISBN(10), equals(true));
    expect('340101319X'.isISBN(10), equals(true));
    expect('3-8362-2119-5'.isISBN(10), equals(true));
    expect('1-61729-085-8'.isISBN(10), equals(true));
    expect('0-00-726970-6'.isISBN(10), equals(true));
    expect('3-423-21412-0'.isISBN(10), equals(true));
    expect('3-401-01319-X'.isISBN(10), equals(true));
    expect('3 8362 2119 5'.isISBN(10), equals(true));
    expect('1 61729 085-8'.isISBN(10), equals(true));
    expect('0 00 726970 6'.isISBN(10), equals(true));
    expect('3 423 21412 0'.isISBN(10), equals(true));
    expect('3 401 01319 X'.isISBN(10), equals(true));
    // invalid
    expect('3423214121'.isISBN(10), equals(false));
    expect('3-423-21412-1'.isISBN(10), equals(false));
    expect('3 423 21412 1'.isISBN(10), equals(false));
    expect('978-3836221191'.isISBN(10), equals(false));
    expect('9783836221191'.isISBN(10), equals(false));
    expect('123456789a'.isISBN(10), equals(false));
    expect('foo'.isISBN(10), equals(false));
    expect(''.isISBN(10), equals(false));
  });

  test('string is an ISBN version 13', () {
    // valid
    expect('9783836221191'.isISBN(13), equals(true));
    expect('9783401013190'.isISBN(13), equals(true));
    expect('9784873113685'.isISBN(13), equals(true));
    expect('978-3-8362-2119-1'.isISBN(13), equals(true));
    expect('978-3401013190'.isISBN(13), equals(true));
    expect('978-4-87311-368-5'.isISBN(13), equals(true));
    expect('978 3 8362 2119 1'.isISBN(13), equals(true));
    expect('978 3401013190'.isISBN(13), equals(true));
    expect('978 4 87311 368 5'.isISBN(13), equals(true));
    // invalid
    expect('9783836221190'.isISBN(13), equals(false));
    expect('3836221195'.isISBN(13), equals(false));
    expect('01234567890ab'.isISBN(13), equals(false));
    expect('978-3-8362-2119-0'.isISBN(13), equals(false));
    expect('3-8362-2119-5'.isISBN(13), equals(false));
    expect('978 3 8362 2119 0'.isISBN(13), equals(false));
    expect('3 8362 2119 5'.isISBN(13), equals(false));
    expect('foo'.isISBN(13), equals(false));
    expect(''.isISBN(13), equals(false));
  });

  test('string is an ISBN (version 10 or 13)', () {
    // valid
    expect('9783836221191'.isISBN(), equals(true));
    expect('9783401013190'.isISBN(), equals(true));
    expect('3423214120'.isISBN(), equals(true));
    expect('340101319X'.isISBN(), equals(true));
    expect('978-3-8362-2119-1'.isISBN(), equals(true));
    expect('978-3401013190'.isISBN(), equals(true));
    expect('3-423-21412-0'.isISBN(), equals(true));
    expect('3-401-01319-X'.isISBN(), equals(true));
    expect('978 3 8362 2119 1'.isISBN(), equals(true));
    expect('978 3401013190'.isISBN(), equals(true));
    expect('3 423 21412 0'.isISBN(), equals(true));
    expect('3 401 01319 X'.isISBN(), equals(true));
    // invalid
    expect('3423214121'.isISBN(), equals(false));
    expect('9783836221190'.isISBN(), equals(false));
    expect('01234567890ab'.isISBN(), equals(false));
    expect('foo'.isISBN(), equals(false));
    expect(''.isISBN(), equals(false));
  });

  test('string is valid JSON', () {
    // valid
    expect('{"key": "v"}'.isJson, equals(true));
    expect('{"1": [1, 2, 3]}'.isJson, equals(true));
    expect('[1, 2, 3]'.isJson, equals(true));
    // invalid
    expect('foo'.isJson, equals(false));
    expect('{ key: "value" }'.isJson, equals(false));
    expect('{ \'key\': \'value\' }'.isJson, equals(false));
  });

  test('string contains one or more multibyte chars', () {
    // valid
    expect('ひらがな・カタカナ、．漢字'.isMultibyte, equals(true));
    expect('あいうえお foobar'.isMultibyte, equals(true));
    expect('test＠example.com'.isMultibyte, equals(true));
    expect('1234abcDEｘｙｚ'.isMultibyte, equals(true));
    // invalid
    expect('abc'.isMultibyte, equals(false));
    expect('<>@" *.'.isMultibyte, equals(false));
  });

  test('string contains ASCII chars only', () {
    // valid
    expect('abc'.isAscii, equals(true));
    expect('<>@" *.'.isAscii, equals(true));
    // invalid
    expect('ひらがな・カタカナ、．漢字'.isAscii, equals(false));
    expect('あいうえお foobar'.isAscii, equals(false));
    expect('test＠example.com'.isAscii, equals(false));
    expect('1234abcDEｘｙｚ'.isAscii, equals(false));
  });

  test('string contains any full-width chars', () {
    // valid
    expect('ひらがな・カタカナ、．漢字'.isFullWidth, equals(true));
    expect('３ー０　ａ＠ｃｏｍ'.isFullWidth, equals(true));
    expect('Ｆｶﾀｶﾅﾞﾬ'.isFullWidth, equals(true));
    // invalid
    expect('abc'.isFullWidth, equals(false));
    expect('abc123'.isFullWidth, equals(false));
    expect(''.isFullWidth, equals(false));
  });

  test('string contains any half-width chars', () {
    // valid
    expect('l-btn_02--active'.isHalfWidth, equals(true));
    expect('abc123い'.isHalfWidth, equals(true));
    expect('ｶﾀｶﾅﾞﾬ￩'.isHalfWidth, equals(true));
    // invalid
    expect('００１１'.isHalfWidth, equals(false));
    expect('あいうえお'.isHalfWidth, equals(false));
    expect(''.isHalfWidth, equals(false));
  });

  test('string contains a mixture of full and half-width chars', () {
    // valid
    expect('ひらがなカタカナ漢字ABCDE'.isVariableWidth, equals(true));
    expect('３ー０123'.isVariableWidth, equals(true));
    expect('Ｆｶﾀｶﾅﾞﾬ'.isVariableWidth, equals(true));
    expect('Good＝Parts'.isVariableWidth, equals(true));
    // invalid
    expect('abc'.isVariableWidth, equals(false));
    expect('abc123'.isVariableWidth, equals(false));
    expect('ひらがな・カタカナ、．漢字'.isVariableWidth, equals(false));
    expect('１２３４５６'.isVariableWidth, equals(false));
    expect(''.isVariableWidth, equals(false));
  });

  test('string contains any surrogate pairs chars', () {
    // valid
    expect('𠮷野𠮷'.isSurrogatePair, equals(true));
    expect('𩸽'.isSurrogatePair, equals(true));
    expect('ABC千𥧄1-2-3'.isSurrogatePair, equals(true));
    // invalid
    expect('吉野竈'.isSurrogatePair, equals(false));
    expect('鮪'.isSurrogatePair, equals(false));
    expect('ABC1-2-3'.isSurrogatePair, equals(false));
  });

  test('strings is MongoId', () {
    // valid
    expect('507f1f77bcf86cd799439011'.isMongoId, equals(true));
    // invalid
    expect('507f1f77bcf86cd7994390'.isMongoId, equals(false));
    expect('507f1f77bcf86cd7994390111'.isMongoId, equals(false));
    expect('G07f1f77bcf86cd799439011'.isMongoId, equals(false));
    expect('507f1f77bcf86cd799439011#'.isMongoId, equals(false));
  });


  test('convert the input to a date, or null if the input is not a date', () {
    expect('2012-02-27 13:27:00'.toDate(),
        equals(DateTime.parse('2012-02-27 13:27:00')));
    expect('abc'.toDate(), equals(null));
  });

  test('convert the input to a float, or NAN if the input is not a float', () {
    expect('1'.toFloat(), equals(1.0));
    expect('2.'.toFloat(), equals(2.0));
    expect('-1.4'.toFloat(), equals(-1.4));
    expect('foo'.toFloat().isNaN, equals(true));
  });

  test('convert the input to an integer, or NAN if the input is not an integer',
      () {
    expect('1.4'.toInt(), equals(1));
    expect('2.'.toInt(), equals(2));
    expect('foo'.toInt().isNaN, equals(true));
  });

  test(
      "convert string to boolean where everything except for '0', 'false' and '' returns `true`",
      () {
    expect('0'.toBoolean(), equals(false));
    expect(''.toBoolean(), equals(false));
    expect('1'.toBoolean(), equals(true));
    expect('true'.toBoolean(), equals(true));
    expect('false'.toBoolean(), equals(false));
    expect('foobar'.toBoolean(), equals(true));
    expect('    '.toBoolean(), equals(true));
  });

  test(
      "convert string to boolean where in `strict` mode only '1' and 'true' return `true`",
      () {
    expect('0'.toBoolean(true), equals(false));
    expect(''.toBoolean(true), equals(false));
    expect('1'.toBoolean(true), equals(true));
    expect('true'.toBoolean(true), equals(true));
    expect('false'.toBoolean(true), equals(false));
    expect('foobar'.toBoolean(true), equals(false));
    expect('    '.toBoolean(true), equals(false));
  });

  test('trim whitespace from both sides of the input', () {
    expect('  \r\n\tfoo  \r\n\t   '.trim(), equals('foo'));
    expect('  \r\n\tfoo  \r\n\t   '.trim(), equals('foo'));
  });

  // test('trim characters from both sides of the input', () {
  //   expect('010100201000'.trim('01'), equals('2'));
  // });

  test('trim whitespace from the left side of the input', () {
    expect('  \r\n\tfoo  \r\n\t   '.ltrim(), equals('foo  \r\n\t   '));
  });

  test('trim characters from the left side of the input', () {
    expect('010100201000'.ltrim('01'), equals('201000'));
  });

  test('trim whitespace from the right side of the input', () {
    expect('  \r\n\tfoo  \r\n\t   '.rtrim(), equals('  \r\n\tfoo'));
  });

  test('trim characters from the right side of the input', () {
    expect('010100201000'.rtrim('01'), equals('0101002'));
  });

  test('remove characters that do not appear in the whitelist', () {
    expect('abcdef'.whitelist('abc'), equals('abc'));
    expect('aaaaaaaaaabbbbbbbbbb'.whitelist('abc'),
        equals('aaaaaaaaaabbbbbbbbbb'));
    expect('a1b2c3'.whitelist('abc'), equals('abc'));
    expect('   '.whitelist('abc'), equals(''));
  });

  test('remove characters that appear in the blacklist', () {
    expect('abcdef'.blacklist('abc'), equals('def'));
    expect('aaaaaaaaaabbbbbbbbbb'.blacklist('abc'), equals(''));
    expect('a1b2c3'.blacklist('abc'), equals('123'));
    expect('   '.blacklist('abc'), equals('   '));
  });

  test(
      'remove characters with a numerical value < 32 and 127 (perserve new lines)',
      () {
    expect('foo\x0A\x0D'.stripLow(true), equals('foo\x0A\x0D'));
    expect('\x03foo\x0A\x0D'.stripLow(true), equals('foo\x0A\x0D'));
  });

  test('remove characters with a numerical value < 32 and 127', () {
    expect('foo\x00'.stripLow(), equals('foo'));
    expect('\x7Ffoo\x02'.stripLow(), equals('foo'));
    expect('\x01\x09'.stripLow(), equals(''));
    expect('foo\x0A\x0D'.stripLow(), equals('foo'));
    expect('perch\u00e9'.stripLow(), equals('perch\u00e9'));
    expect('\u20ac'.stripLow(), equals('\u20ac'));
    expect('\u2206\x0A'.stripLow(), equals('\u2206'));
  });

  test('replace `<`, `>`, `&`, `\'` and `"` with HTML entities', () {
    expect('<img alt="foo&bar">'.escape(),
        equals('&lt;img alt=&quot;foo&amp;bar&quot;&gt;'));
    expect("<img alt='foo&bar'>".escape(),
        equals('&lt;img alt=&#x27;foo&amp;bar&#x27;&gt;'));
  });

  test('canonicalize an email address', () {
    expect('test@me.com'.normalizeEmail(), equals('test@me.com'));
    expect(
        'some.name@gmail.com'.normalizeEmail(), equals('somename@gmail.com'));
    expect('some.name@googleMail.com'.normalizeEmail(),
        equals('somename@gmail.com'));
    expect('some.name+extension@gmail.com'.normalizeEmail(),
        equals('somename@gmail.com'));
    expect('some.Name+extension@GoogleMail.com'.normalizeEmail(),
        equals('somename@gmail.com'));
    expect('some.name.middleName+extension@gmail.com'.normalizeEmail(),
        equals('somenamemiddlename@gmail.com'));
    expect('some.name.midd.leNa.me.+extension@gmail.com'.normalizeEmail(),
        equals('somenamemiddlename@gmail.com'));
    expect('some.name+extension@unknown.com'.normalizeEmail(),
        equals('some.name+extension@unknown.com'));
    expect('hans@m端ller.com'.normalizeEmail(), equals('hans@m端ller.com'));
    expect('an invalid email address'.normalizeEmail(), equals(''));
    expect(''.normalizeEmail(), equals(''));
  });

  test('canonicalize an email address with lowercase false', () {
    expect('test@me.com'.normalizeEmail({'lowercase': false}),
        equals('test@me.com'));
    expect('hans@m端ller.com'.normalizeEmail({'lowercase': false}),
        equals('hans@m端ller.com'));
    expect('test@ME.COM'.normalizeEmail({'lowercase': false}),
        equals('test@me.com'));
    expect('TEST@me.com'.normalizeEmail({'lowercase': false}),
        equals('TEST@me.com'));
    expect('TEST@ME.COM'.normalizeEmail({'lowercase': false}),
        equals('TEST@me.com'));
    expect('blAH@x.com'.normalizeEmail({'lowercase': false}),
        equals('blAH@x.com'));
    expect('SOME.name@GMAIL.com'.normalizeEmail({'lowercase': false}),
        equals('somename@gmail.com'));
    expect(
        'SOME.name.middleName+extension@GoogleMail.com'
            .normalizeEmail({'lowercase': false}),
        equals('somenamemiddlename@gmail.com'));
    expect(
        'SOME.name.midd.leNa.me.+extension@gmail.com'
            .normalizeEmail({'lowercase': false}),
        equals('somenamemiddlename@gmail.com'));
  });
}
