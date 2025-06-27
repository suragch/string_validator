import "package:test/test.dart";
import 'package:string_validator/string_validator.dart' as v;

void main() {
  test('strings are equal', () {
    // valid
    expect(v.equals('abc', 'abc'), equals(true));
    // invalid
    expect(v.equals('abc', 'Abc'), equals(false));
    expect(v.equals('abc', '123'), equals(false));
    expect(v.equals('abc', null), equals(false));
  });

  test('strings contains substring', () {
    // valid
    expect(v.contains('foo', 'foo'), equals(true));
    expect(v.contains('foobar', 'foo'), equals(true));
    expect(v.contains('bazfoo', 'foo'), equals(true));
    // invalid
    expect(v.contains('Foo', 'foo'), equals(false));
    expect(v.contains('bar', 'foo'), equals(false));
  });

  test('strings has matching pattern', () {
    // valid
    expect(v.matches('abc', 'abc'), equals(true));
    expect(v.matches('abcdef', 'abc'), equals(true));
    expect(v.matches('123abc', 'abc'), equals(true));
    // invalid
    expect(v.matches('acb', 'abc'), equals(false));
    expect(v.matches('ABC', 'abc'), equals(false));
  });

  test('strings is email', () {
    // valid
    expect(v.isEmail('foo@bar.com'), equals(true));
    expect(v.isEmail('x@x.x'), equals(true));
    expect(v.isEmail('foo@bar.com.au'), equals(true));
    expect(v.isEmail('foo+bar@bar.com'), equals(true));
    expect(v.isEmail('hans.m端ller@test.com'), equals(true));
    expect(v.isEmail('hans@m端ller.com'), equals(true));
    expect(v.isEmail('test|123@m端ller.com'), equals(true));
    expect(v.isEmail('test+ext@gmail.com'), equals(true));
    expect(v.isEmail('some.name.midd.leNa.me.+extension@GoogleMail.com'),
        equals(true));
    // invalid
    expect(v.isEmail('invalidemail@'), equals(false));
    expect(v.isEmail('invalid.com'), equals(false));
    expect(v.isEmail('@invalid.com'), equals(false));
    expect(v.isEmail('foo@bar.com.'), equals(false));
    expect(v.isEmail('foo@bar.co.uk.'), equals(false));
  });

  test('strings is valid url', () {
    // valid
    expect(v.isURL('foobar.com'), equals(true));
    expect(v.isURL('www.foobar.com'), equals(true));
    expect(v.isURL('foobar.com/'), equals(true));
    expect(v.isURL('valid.au'), equals(true));
    expect(v.isURL('http://www.foobar.com/'), equals(true));
    expect(v.isURL('http://www.foobar.com:23/'), equals(true));
    expect(v.isURL('http://www.foobar.com:65535/'), equals(true));
    expect(v.isURL('http://www.foobar.com:5/'), equals(true));
    expect(v.isURL('https://www.foobar.com/'), equals(true));
    expect(v.isURL('ftp://www.foobar.com/'), equals(true));
    expect(v.isURL('http://www.foobar.com/~foobar'), equals(true));
    expect(v.isURL('http://user:pass@www.foobar.com/'), equals(true));
    expect(v.isURL('http://127.0.0.1/'), equals(true));
    expect(v.isURL('http://10.0.0.0/'), equals(true));
    expect(v.isURL('http://189.123.14.13/'), equals(true));
    expect(v.isURL('http://duckduckgo.com/?q=%2F'), equals(true));
    expect(v.isURL('http://foobar.com/t\$-_.+!*\'(),'), equals(true));
    expect(v.isURL('http://localhost:3000/'), equals(true));
    expect(v.isURL('http://foobar.com/?foo=bar#baz=qux'), equals(true));
    expect(v.isURL('http://foobar.com?foo=bar'), equals(true));
    expect(v.isURL('http://foobar.com#baz=qux'), equals(true));
    expect(v.isURL('http://www.xn--froschgrn-x9a.net/'), equals(true));
    expect(v.isURL('http://xn--froschgrn-x9a.com/'), equals(true));
    expect(v.isURL('http://foo--bar.com'), equals(true));
    expect(v.isURL('http://username:token@example.com/protected/files'),
        equals(true));
    // invalid
    expect(v.isURL('xyz://foobar.com'), equals(false));
    expect(v.isURL('invalid/'), equals(false));
    expect(v.isURL('invalid.x'), equals(false));
    expect(v.isURL('invalid.'), equals(false));
    expect(v.isURL('.com'), equals(false));
    expect(v.isURL('http://com/'), equals(false));
    expect(v.isURL('http://300.0.0.1/'), equals(false));
    expect(v.isURL('mailto:foo@bar.com'), equals(false));
    expect(v.isURL('rtmp://foobar.com'), equals(false));
    expect(v.isURL('http://www.xn--.com/'), equals(false));
    expect(v.isURL('http://xn--.com/'), equals(false));
    expect(v.isURL('http://www.foobar.com:0/'), equals(false));
    expect(v.isURL('http://www.foobar.com:70000/'), equals(false));
    expect(v.isURL('http://www.foobar.com:99999/'), equals(false));
    expect(v.isURL('http://www.-foobar.com/'), equals(false));
    expect(v.isURL('http://www.foobar-.com/'), equals(false));
    expect(v.isURL('http://www.foo---bar.com/'), equals(false));
    expect(v.isURL('http://www.foo_bar.com/'), equals(false));
    expect(v.isURL(''), equals(false));
    expect(v.isURL('http://foobar.com/${'f' * 2083}'), equals(false));
    expect(v.isURL('http://*.foo.com'), equals(false));
    expect(v.isURL('*.foo.com'), equals(false));
    expect(v.isURL('!.foo.com'), equals(false));
    expect(v.isURL('http://localhost:61500this is an invalid url!!!!'),
        equals(false));
  });

  test('strings is valid IP', () {
    // valid
    expect(v.isIP('127.0.0.1'), equals(true));
    expect(v.isIP('0.0.0.0'), equals(true));
    expect(v.isIP('255.255.255.255'), equals(true));
    expect(v.isIP('1.2.3.4'), equals(true));
    expect(v.isIP('::1'), equals(true));
    expect(v.isIP('2001:db8:0000:1:1:1:1:1'), equals(true));
    expect(v.isIP('2001:db8::192.0.2.33'), equals(true));
    expect(v.isIP('2a02:2d8:0:4817:232a::'), equals(true));

    expect(v.isIP('2001:0db8:85a3:0000:0000:8a2e:0370:7334'), equals(true));
    expect(v.isIP('2001:db8::1'), equals(true));
    expect(v.isIP('::1'), equals(true));
    expect(v.isIP('fe80::1ff:fe23:4567:890a'), equals(true));
    expect(v.isIP('ff00::'), equals(true));


    // Note: CIDR notation like '2001:db8::/32' is not a valid pure IP address, so validation should be false
    expect(v.isIP('2001:db8::/32'), equals(false));


    // invalid
    expect(v.isIP('abc'), equals(false));
    expect(v.isIP('256.0.0.0'), equals(false));
    expect(v.isIP('0.0.0.256'), equals(false));
    expect(v.isIP('26.0.0.256'), equals(false));
    expect(v.isIP('01.02.03.004'), equals(false));

    expect(v.isIP('2001:::1'), equals(false));
    expect(v.isIP('12345::'), equals(false));
    expect(v.isIP('2001:db8::1/129'), equals(false));
    expect(v.isIP('gggg::1'), equals(false));
    expect(v.isIP('2001:db8:85a3::8a2e::7334'), equals(false));
    expect(v.isIP(':::/64'), equals(false));


  });

  test('strings contains only letters (a-zA-Z)', () {
    // valid
    expect(v.isAlpha('abc'), equals(true));
    expect(v.isAlpha('ABC'), equals(true));
    expect(v.isAlpha('FoObAr'), equals(true));
    // invalid
    expect(v.isAlpha('abc1'), equals(false));
    expect(v.isAlpha('AB  C'), equals(false));
    expect(v.isAlpha(''), equals(false));
  });

  test('string contains only letters and numbers', () {
    // valid
    expect(v.isAlphanumeric('abc1'), equals(true));
    expect(v.isAlphanumeric('0A1BC'), equals(true));
    expect(v.isAlphanumeric('Fo0bAr'), equals(true));
    // invalid
    expect(v.isAlphanumeric('abc!'), equals(false));
    expect(v.isAlphanumeric('AB C'), equals(false));
    expect(v.isAlphanumeric(''), equals(false));
  });

  test('string contains only numbers', () {
    // valid
    expect(v.isNumeric('-1'), equals(true));
    expect(v.isNumeric('0'), equals(true));
    expect(v.isNumeric('00'), equals(true));
    expect(v.isNumeric('01'), equals(true));
    expect(v.isNumeric('19934'), equals(true));
    expect(v.isNumeric('-23412'), equals(true));
    // invalid
    expect(v.isNumeric('abc!'), equals(false));
    expect(v.isNumeric('AB C'), equals(false));
    expect(v.isNumeric(''), equals(false));
    expect(v.isNumeric('1.2'), equals(false));
  });

  test('string contains only numbers', () {
    // valid
    expect(
        v.isBase64(
            'TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNlY3RldHVyIGFkaXBpc2NpbmcgZWxpdC4='),
        equals(true));
    expect(v.isBase64('Vml2YW11cyBmZXJtZW50dW0gc2VtcGVyIHBvcnRhLg=='),
        equals(true));
    expect(v.isBase64('U3VzcGVuZGlzc2UgbGVjdHVzIGxlbw=='), equals(true));
    expect(
        v.isBase64(
            'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuMPNS1Ufof9EW/M98FNwUAKrwflsqVxaxQjBQnHQmiI7Vac40t8x7pIb8gLGV6wL7sBTJiPovJ0V7y7oc0YerhKh0Rm4skP2z/jHwwZICgGzBvA0rH8xlhUiTvcwDCJ0kc+fh35hNt8srZQM4619FTgB66Xmp4EtVyhpQV+t02g6NzK72oZI0vnAvqhpkxLeLiMCyrI416wHm5TkukhxQmcL2a6hNOyu0ixX/x2kSFXApEnVrJ+/IxGyfyw8kf4N2IZpW5nEP847lpfj0SZZFwrd1mnfnDbYohX2zRptLy2ZUn06Qo9pkG5ntvFEPo9bfZeULtjYzIl6K8gJ2uGZHQIDAQAB'),
        equals(true));
    // invalid
    expect(v.isBase64('abc!'), equals(false));
    expect(v.isBase64('AB C'), equals(false));
    expect(v.isBase64('Vml2YW11cyBmZXJtZtesting123'), equals(false));
    expect(v.isBase64(''), equals(false));
  });

  test('string is an integer', () {
    // valid
    expect(v.isInt('-1'), equals(true));
    expect(v.isInt('0'), equals(true));
    expect(v.isInt('10'), equals(true));
    expect(v.isInt('23423'), equals(true));
    expect(v.isInt('19934'), equals(true));
    expect(v.isInt('-23412'), equals(true));
    // invalid
    expect(v.isInt('-01'), equals(false));
    expect(v.isInt('000'), equals(false));
    expect(v.isInt('12.13'), equals(false));
    expect(v.isInt('AB'), equals(false));
    expect(v.isInt(''), equals(false));
  });

  test('string is a float', () {
    // valid
    expect(v.isFloat('-1.324'), equals(true));
    expect(v.isFloat('0.32'), equals(true));
    expect(v.isFloat('-0.324'), equals(true));
    expect(v.isFloat('2423.234234'), equals(true));
    expect(v.isFloat('-0.22250738585072011e-307'), equals(true));
    expect(v.isFloat('0.22250738585072011e-307'), equals(true));
    // invalid
    expect(v.isFloat('abc!'), equals(false));
    expect(v.isFloat('AB C'), equals(false));
    expect(v.isFloat(' '), equals(false));
  });

  test('string is a hexadecimal number', () {
    // valid
    expect(v.isHexadecimal('deadBEEF'), equals(true));
    expect(v.isHexadecimal('ff0044'), equals(true));
    // invalid
    expect(v.isHexadecimal('abcdefg'), equals(false));
    expect(v.isHexadecimal(' '), equals(false));
    expect(v.isHexadecimal('..'), equals(false));
  });

  test('string is a hexadecimal color', () {
    // valid
    expect(v.isHexColor('#ff0034'), equals(true));
    expect(v.isHexColor('#CCCCCC'), equals(true));
    expect(v.isHexColor('fff'), equals(true));
    expect(v.isHexColor('#f00'), equals(true));
    // invalid
    expect(v.isHexColor('#ff'), equals(false));
    expect(v.isHexColor('fff0'), equals(false));
    expect(v.isHexColor('#ff12FG'), equals(false));
  });

  test('string is lowercase', () {
    // valid
    expect(v.isLowercase('abc'), equals(true));
    expect(v.isLowercase('abc123'), equals(true));
    expect(v.isLowercase('l.o.w.e.r.'), equals(true));
    expect(v.isLowercase('tr竪s 端ber'), equals(true));
    // invalid
    expect(v.isLowercase('f00Bar'), equals(false));
    expect(v.isLowercase('uUu'), equals(false));
  });

  test('string is uppercase', () {
    // valid
    expect(v.isUppercase('ABC'), equals(true));
    expect(v.isUppercase('ABC123'), equals(true));
    expect(v.isUppercase('U.P.P.E.R.'), equals(true));
    // invalid
    expect(v.isUppercase('f00Bar'), equals(false));
    expect(v.isUppercase('uUu'), equals(false));
  });

  test('string is a number that\'s divisible by another', () {
    // valid
    expect(v.isDivisibleBy('2', '2'), equals(true));
    expect(v.isDivisibleBy('4', '2'), equals(true));
    expect(v.isDivisibleBy('100', '2'), equals(true));
    expect(v.isDivisibleBy('-10', '2'), equals(true));
    // invalid
    expect(v.isDivisibleBy('1', '2'), equals(false));
    expect(v.isDivisibleBy('-1', '2'), equals(false));
    expect(v.isDivisibleBy('abc', '2'), equals(false));
  });

  test('length at least', () {
    // valid
    expect(v.isLength('ab', 2), equals(true));
    expect(v.isLength('de', 2), equals(true));
    expect(v.isLength('abcd', 2), equals(true));
    expect(v.isLength('干𩸽', 2), equals(true));
    // invalid
    expect(v.isLength('', 2), equals(false));
    expect(v.isLength('a', 2), equals(false));
    expect(v.isLength('𠀋', 2), equals(false));
  });

  test('length in range', () {
    // valid
    expect(v.isLength('abc', 2, 3), equals(true));
    expect(v.isLength('de', 2, 3), equals(true));
    expect(v.isLength('干𩸽', 2, 3), equals(true));
    // invalid
    expect(v.isLength('', 2, 3), equals(false));
    expect(v.isLength('𠀋', 2, 3), equals(false));
    expect(v.isLength('千竈通り', 2, 3), equals(false));
  });

  test('byte length at least', () {
    // valid
    expect(v.isByteLength('ab', 2), equals(true));
    expect(v.isByteLength('de', 2), equals(true));
    expect(v.isByteLength('abcd', 2), equals(true));
    expect(v.isByteLength('干𩸽', 2), equals(true));
    expect(v.isByteLength('𠀋', 2), equals(true));
    // invalid
    expect(v.isByteLength('', 2), equals(false));
    expect(v.isByteLength('a', 2), equals(false));
  });

  test('byte length in range', () {
    // valid
    expect(v.isByteLength('abc', 2, 3), equals(true));
    expect(v.isByteLength('de', 2, 3), equals(true));
    expect(v.isByteLength('干𩸽', 2, 3), equals(true));
    expect(v.isByteLength('𠀋', 2, 3), equals(true));
    // invalid
    expect(v.isByteLength('', 2, 3), equals(false));
    expect(v.isByteLength('千竈通り', 2, 3), equals(false));
  });

  test('string is a UUID (version 3, 4 or 5)', () {
    // valid
    expect(v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3'), equals(true));
    expect(v.isUUID('A987FBC9-4BED-4078-8F07-9141BA07C9F3'), equals(true));
    expect(v.isUUID('A987FBC9-4BED-5078-AF07-9141BA07C9F3'), equals(true));
    // invalid
    expect(v.isUUID(''), equals(false));
    expect(v.isUUID('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3'), equals(false));
    expect(v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx'), equals(false));
    expect(v.isUUID('A987FBC94BED3078CF079141BA07C9F3'), equals(false));
    expect(v.isUUID('934859'), equals(false));
    expect(v.isUUID('987FBC9-4BED-3078-CF07A-9141BA07C9F3'), equals(false));
    expect(v.isUUID('AAAAAAAA-1111-1111-AAAG-111111111111'), equals(false));
  });

  test('string is a UUID version 3', () {
    // valid
    expect(v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3', 3), equals(true));
    // invalid
    expect(v.isUUID('', 3), equals(false));
    expect(
        v.isUUID('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3', 3), equals(false));
    expect(
        v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx', 3), equals(false));
    expect(v.isUUID('A987FBC94BED3078CF079141BA07C9F3', 3), equals(false));
    expect(v.isUUID('934859', 3), equals(false));
    expect(v.isUUID('987FBC9-4BED-3078-CF07A-9141BA07C9F3', 3), equals(false));
    expect(v.isUUID('AAAAAAAA-1111-1111-AAAG-111111111111', 3), equals(false));
  });

  test('string is a UUID version 4', () {
    // valid
    expect(v.isUUID('713ae7e3-cb32-45f9-adcb-7c4fa86b90c1', 4), equals(true));
    expect(v.isUUID('625e63f3-58f5-40b7-83a1-a72ad31acffb', 4), equals(true));
    expect(v.isUUID('57b73598-8764-4ad0-a76a-679bb6640eb1', 4), equals(true));
    // invalid
    expect(v.isUUID('', 4), equals(false));
    expect(
        v.isUUID('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3', 4), equals(false));
    expect(
        v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx', 4), equals(false));
    expect(v.isUUID('A987FBC94BED3078CF079141BA07C9F3', 4), equals(false));
    expect(v.isUUID('934859', 4), equals(false));
    expect(v.isUUID('987FBC9-4BED-3078-CF07A-9141BA07C9F3', 4), equals(false));
    expect(v.isUUID('AAAAAAAA-1111-1111-AAAG-111111111111', 4), equals(false));
  });

  test('string is a UUID version 5', () {
    // valid
    expect(v.isUUID('987FBC97-4BED-5078-AF07-9141BA07C9F3', 5), equals(true));
    expect(v.isUUID('987FBC97-4BED-5078-BF07-9141BA07C9F3', 5), equals(true));
    expect(v.isUUID('987FBC97-4BED-5078-8F07-9141BA07C9F3', 5), equals(true));
    // invalid
    expect(v.isUUID('', 5), equals(false));
    expect(
        v.isUUID('xxxA987FBC9-4BED-3078-CF07-9141BA07C9F3', 5), equals(false));
    expect(
        v.isUUID('A987FBC9-4BED-3078-CF07-9141BA07C9F3xxx', 5), equals(false));
    expect(v.isUUID('A987FBC94BED3078CF079141BA07C9F3', 5), equals(false));
    expect(v.isUUID('934859', 5), equals(false));
    expect(v.isUUID('987FBC9-4BED-3078-CF07A-9141BA07C9F3', 5), equals(false));
    expect(v.isUUID('AAAAAAAA-1111-1111-AAAG-111111111111', 5), equals(false));
  });

  test('string is a date', () {
    // valid
    expect(v.isDate('2012-02-27 13:27:00'), equals(true));
    expect(v.isDate('2012-02-27'), equals(true));
    expect(v.isDate('2011-08-04 12:00'), equals(true));
    expect(v.isDate('2012-02-27 13:27:00.123456z'), equals(true));
    expect(v.isDate('20120227'), equals(true));
    expect(v.isDate('2002-02-27T14:00:00-0500'), equals(true));
    expect(v.isDate('2002-02-27T19:00:00Z'), equals(true));
    // invalid
    expect(v.isDate(''), equals(false));
    expect(v.isDate('aaaafff'), equals(false));
    expect(v.isDate('ABC'), equals(false));
  });

  test('string is a date after the specified date', () {
    // valid
    expect(v.isAfter('2012-12-12', '2005-12-12'), equals(true));
    expect(v.isAfter('2012-02-27 13:27:00', '2005-12-12'), equals(true));
    expect(v.isAfter('2022-02-27T14:00:00-0500', '2005-12-12'), equals(true));
    // invalid
    expect(v.isAfter('2002-12-12', '2005-12-12'), equals(false));
    expect(v.isAfter('2002-02-27 13:27:00', '2005-12-12'), equals(false));
    expect(v.isAfter('2002-02-27T14:00:00-0500', '2005-12-12'), equals(false));
    expect(v.isAfter(' ', '2005-12-12'), equals(false));
    expect(v.isAfter('', '2005-12-12'), equals(false));
  });

  test('string is a date after now', () {
    // valid
    expect(v.isAfter('2032-12-12'), equals(true));
    expect(v.isAfter('2032-02-27 13:27:00'), equals(true));
    expect(v.isAfter('2032-02-27T14:00:00-0500'), equals(true));
    // invalid
    expect(v.isAfter('2002-12-12'), equals(false));
    expect(v.isAfter('2002-02-27 13:27:00'), equals(false));
    expect(v.isAfter('2002-02-27T14:00:00-0500'), equals(false));
    expect(v.isAfter(' '), equals(false));
    expect(v.isAfter(''), equals(false));
  });

  test('string is a date before the specified date', () {
    // valid
    expect(v.isBefore('2002-12-12', '2005-12-12'), equals(true));
    expect(v.isBefore('2002-02-27 13:27:00', '2005-12-12'), equals(true));
    expect(v.isBefore('2002-02-27T14:00:00-0500', '2005-12-12'), equals(true));
    // invalid
    expect(v.isBefore('2022-12-12', '2005-12-12'), equals(false));
    expect(v.isBefore('2022-02-27 13:27:00', '2005-12-12'), equals(false));
    expect(v.isBefore('2022-02-27T14:00:00-0500', '2005-12-12'), equals(false));
    expect(v.isBefore(' ', '2005-12-12'), equals(false));
    expect(v.isBefore('', '2005-12-12'), equals(false));
  });

  test('string is a date before now', () {
    // valid
    expect(v.isBefore('2012-12-12'), equals(true));
    expect(v.isBefore('2012-02-27 13:27:00'), equals(true));
    expect(v.isBefore('2012-02-27T14:00:00-0500'), equals(true));
    // invalid
    expect(v.isBefore('2032-12-12'), equals(false));
    expect(v.isBefore('2032-02-27 13:27:00'), equals(false));
    expect(v.isBefore('2032-02-27T14:00:00-0500'), equals(false));
    expect(v.isBefore(' '), equals(false));
    expect(v.isBefore(''), equals(false));
  });

  test('string is in bigger string', () {
    // valid
    expect(v.isIn('foo', 'foobar'), equals(true));
    expect(v.isIn('bar', 'foobar'), equals(true));
    expect(v.isIn('oba', 'foobar'), equals(true));
    expect(v.isIn('foobar', 'foobar'), equals(true));
    expect(v.isIn('', 'foobar'), equals(true));
    // invalid
    expect(v.isIn('1', 'foobar'), equals(false));
    expect(v.isIn(' ', 'foobar'), equals(false));
  });

  test('string is in an array of allowed values', () {
    // valid
    expect(v.isIn('1', [1, 2, 3]), equals(true));
    expect(v.isIn('2', [1, 2, 3]), equals(true));
    expect(v.isIn('3', [1, 2, 3]), equals(true));
    // invalid
    expect(v.isIn('4', [1, 2, 3]), equals(false));
    expect(v.isIn(' ', [1, 2, 3]), equals(false));
  });

  test('string', () {
    // valid
    expect(v.isCreditCard('375556917985515'), equals(true));
    expect(v.isCreditCard('36050234196908'), equals(true));
    expect(v.isCreditCard('4716461583322103'), equals(true));
    expect(v.isCreditCard('4716-2210-5188-5662'), equals(true));
    expect(v.isCreditCard('4929 7226 5379 7141'), equals(true));
    expect(v.isCreditCard('5398228707871527'), equals(true));
    // invalid
    expect(v.isCreditCard('5398228707871528'), equals(false));
    expect(v.isCreditCard(''), equals(false));
    expect(v.isCreditCard('Lol0'), equals(false));
  });

  test('string is an ISBN version 10', () {
    // valid
    expect(v.isISBN('3836221195', 10), equals(true));
    expect(v.isISBN('1617290858', 10), equals(true));
    expect(v.isISBN('0007269706', 10), equals(true));
    expect(v.isISBN('3423214120', 10), equals(true));
    expect(v.isISBN('340101319X', 10), equals(true));
    expect(v.isISBN('3-8362-2119-5', 10), equals(true));
    expect(v.isISBN('1-61729-085-8', 10), equals(true));
    expect(v.isISBN('0-00-726970-6', 10), equals(true));
    expect(v.isISBN('3-423-21412-0', 10), equals(true));
    expect(v.isISBN('3-401-01319-X', 10), equals(true));
    expect(v.isISBN('3 8362 2119 5', 10), equals(true));
    expect(v.isISBN('1 61729 085-8', 10), equals(true));
    expect(v.isISBN('0 00 726970 6', 10), equals(true));
    expect(v.isISBN('3 423 21412 0', 10), equals(true));
    expect(v.isISBN('3 401 01319 X', 10), equals(true));
    // invalid
    expect(v.isISBN('3423214121', 10), equals(false));
    expect(v.isISBN('3-423-21412-1', 10), equals(false));
    expect(v.isISBN('3 423 21412 1', 10), equals(false));
    expect(v.isISBN('978-3836221191', 10), equals(false));
    expect(v.isISBN('9783836221191', 10), equals(false));
    expect(v.isISBN('123456789a', 10), equals(false));
    expect(v.isISBN('foo', 10), equals(false));
    expect(v.isISBN('', 10), equals(false));
  });

  test('string is an ISBN version 13', () {
    // valid
    expect(v.isISBN('9783836221191', 13), equals(true));
    expect(v.isISBN('9783401013190', 13), equals(true));
    expect(v.isISBN('9784873113685', 13), equals(true));
    expect(v.isISBN('978-3-8362-2119-1', 13), equals(true));
    expect(v.isISBN('978-3401013190', 13), equals(true));
    expect(v.isISBN('978-4-87311-368-5', 13), equals(true));
    expect(v.isISBN('978 3 8362 2119 1', 13), equals(true));
    expect(v.isISBN('978 3401013190', 13), equals(true));
    expect(v.isISBN('978 4 87311 368 5', 13), equals(true));
    // invalid
    expect(v.isISBN('9783836221190', 13), equals(false));
    expect(v.isISBN('3836221195', 13), equals(false));
    expect(v.isISBN('01234567890ab', 13), equals(false));
    expect(v.isISBN('978-3-8362-2119-0', 13), equals(false));
    expect(v.isISBN('3-8362-2119-5', 13), equals(false));
    expect(v.isISBN('978 3 8362 2119 0', 13), equals(false));
    expect(v.isISBN('3 8362 2119 5', 13), equals(false));
    expect(v.isISBN('foo', 13), equals(false));
    expect(v.isISBN('', 13), equals(false));
  });

  test('string is an ISBN (version 10 or 13)', () {
    // valid
    expect(v.isISBN('9783836221191'), equals(true));
    expect(v.isISBN('9783401013190'), equals(true));
    expect(v.isISBN('3423214120'), equals(true));
    expect(v.isISBN('340101319X'), equals(true));
    expect(v.isISBN('978-3-8362-2119-1'), equals(true));
    expect(v.isISBN('978-3401013190'), equals(true));
    expect(v.isISBN('3-423-21412-0'), equals(true));
    expect(v.isISBN('3-401-01319-X'), equals(true));
    expect(v.isISBN('978 3 8362 2119 1'), equals(true));
    expect(v.isISBN('978 3401013190'), equals(true));
    expect(v.isISBN('3 423 21412 0'), equals(true));
    expect(v.isISBN('3 401 01319 X'), equals(true));
    // invalid
    expect(v.isISBN('3423214121'), equals(false));
    expect(v.isISBN('9783836221190'), equals(false));
    expect(v.isISBN('01234567890ab'), equals(false));
    expect(v.isISBN('foo'), equals(false));
    expect(v.isISBN(''), equals(false));
  });

  test('string is valid JSON', () {
    // valid
    expect(v.isJson('{"key": "v"}'), equals(true));
    expect(v.isJson('{"1": [1, 2, 3]}'), equals(true));
    expect(v.isJson('[1, 2, 3]'), equals(true));
    // invalid
    expect(v.isJson('foo'), equals(false));
    expect(v.isJson('{ key: "value" }'), equals(false));
    expect(v.isJson('{ \'key\': \'value\' }'), equals(false));
  });

  test('string contains one or more multibyte chars', () {
    // valid
    expect(v.isMultibyte('ひらがな・カタカナ、．漢字'), equals(true));
    expect(v.isMultibyte('あいうえお foobar'), equals(true));
    expect(v.isMultibyte('test＠example.com'), equals(true));
    expect(v.isMultibyte('1234abcDEｘｙｚ'), equals(true));
    // invalid
    expect(v.isMultibyte('abc'), equals(false));
    expect(v.isMultibyte('<>@" *.'), equals(false));
  });

  test('string contains ASCII chars only', () {
    // valid
    expect(v.isAscii('abc'), equals(true));
    expect(v.isAscii('<>@" *.'), equals(true));
    // invalid
    expect(v.isAscii('ひらがな・カタカナ、．漢字'), equals(false));
    expect(v.isAscii('あいうえお foobar'), equals(false));
    expect(v.isAscii('test＠example.com'), equals(false));
    expect(v.isAscii('1234abcDEｘｙｚ'), equals(false));
  });

  test('string contains any full-width chars', () {
    // valid
    expect(v.isFullWidth('ひらがな・カタカナ、．漢字'), equals(true));
    expect(v.isFullWidth('３ー０　ａ＠ｃｏｍ'), equals(true));
    expect(v.isFullWidth('Ｆｶﾀｶﾅﾞﾬ'), equals(true));
    // invalid
    expect(v.isFullWidth('abc'), equals(false));
    expect(v.isFullWidth('abc123'), equals(false));
    expect(v.isFullWidth(''), equals(false));
  });

  test('string contains any half-width chars', () {
    // valid
    expect(v.isHalfWidth('l-btn_02--active'), equals(true));
    expect(v.isHalfWidth('abc123い'), equals(true));
    expect(v.isHalfWidth('ｶﾀｶﾅﾞﾬ￩'), equals(true));
    // invalid
    expect(v.isHalfWidth('００１１'), equals(false));
    expect(v.isHalfWidth('あいうえお'), equals(false));
    expect(v.isHalfWidth(''), equals(false));
  });

  test('string contains a mixture of full and half-width chars', () {
    // valid
    expect(v.isVariableWidth('ひらがなカタカナ漢字ABCDE'), equals(true));
    expect(v.isVariableWidth('３ー０123'), equals(true));
    expect(v.isVariableWidth('Ｆｶﾀｶﾅﾞﾬ'), equals(true));
    expect(v.isVariableWidth('Good＝Parts'), equals(true));
    // invalid
    expect(v.isVariableWidth('abc'), equals(false));
    expect(v.isVariableWidth('abc123'), equals(false));
    expect(v.isVariableWidth('ひらがな・カタカナ、．漢字'), equals(false));
    expect(v.isVariableWidth('１２３４５６'), equals(false));
    expect(v.isVariableWidth(''), equals(false));
  });

  test('string contains any surrogate pairs chars', () {
    // valid
    expect(v.isSurrogatePair('𠮷野𠮷'), equals(true));
    expect(v.isSurrogatePair('𩸽'), equals(true));
    expect(v.isSurrogatePair('ABC千𥧄1-2-3'), equals(true));
    // invalid
    expect(v.isSurrogatePair('吉野竈'), equals(false));
    expect(v.isSurrogatePair('鮪'), equals(false));
    expect(v.isSurrogatePair('ABC1-2-3'), equals(false));
  });

  test('string is a valid hex-encoded representation of a MongoDB ObjectId',
      () {
    // valid
    expect(v.isMongoId('507f1f77bcf86cd799439011'), equals(true));
    // invalid
    expect(v.isMongoId('507f1f77bcf86cd7994390'), equals(false));
    expect(v.isMongoId('507f1f77bcf86cd7994390z'), equals(false));
    expect(v.isMongoId(''), equals(false));
  });
}
