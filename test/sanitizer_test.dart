import "package:test/test.dart";
import 'package:string_validator/string_validator.dart' as s;

void main() {

  test('convert the input to a string', () {
    expect(s.toString(1), equals('1'));
    expect(s.toString(1.5), equals('1.5'));
    expect(s.toString({1: 2}), equals('{1: 2}'));
    expect(s.toString(null), equals(''));
  });

  test('convert the input to a date, or null if the input is not a date', () {
    expect(s.toDate('2012-02-27 13:27:00'), equals(DateTime.parse('2012-02-27 13:27:00')));
    expect(s.toDate('abc'), equals(null));
  });

  test('convert the input to a float, or NAN if the input is not a float', () {
    expect(s.toFloat('1'), equals(1.0));
    expect(s.toFloat('2.'), equals(2.0));
    expect(s.toFloat('-1.4'), equals(-1.4));
    expect(s.toFloat('foo'), isNaN);
  });

  test('convert the input to an integer, or NAN if the input is not an integer', () {
    expect(s.toInt('1.4'), equals(1));
    expect(s.toInt('2.'), equals(2));
    expect(s.toInt('foo'), isNaN);
  });

  test("convert string to boolean where everything except for '0', 'false' and '' returns `true`", () {
    expect(s.toBoolean('0'), equals(false));
    expect(s.toBoolean(''), equals(false));
    expect(s.toBoolean('1'), equals(true));
    expect(s.toBoolean('true'), equals(true));
    expect(s.toBoolean('false'), equals(false));
    expect(s.toBoolean('foobar'), equals(true));
    expect(s.toBoolean('    '), equals(true));
  });

  test("convert string to boolean where in `strict` mode only '1' and 'true' return `true`", () {
    expect(s.toBoolean('0', true), equals(false));
    expect(s.toBoolean('', true), equals(false));
    expect(s.toBoolean('1', true), equals(true));
    expect(s.toBoolean('true', true), equals(true));
    expect(s.toBoolean('false', true), equals(false));
    expect(s.toBoolean('foobar', true), equals(false));
    expect(s.toBoolean('    ', true), equals(false));
  });

  test('trim whitespace from both sides of the input', () {
    expect(s.trim('  \r\n\tfoo  \r\n\t   '), equals('foo'));
    expect(s.trim('  \r\n\tfoo  \r\n\t   '), equals('foo'));
  });

  test('trim characters from both sides of the input', () {
    expect(s.trim('010100201000', '01'), equals('2'));
  });

  test('trim whitespace from the left side of the input', () {
    expect(s.ltrim('  \r\n\tfoo  \r\n\t   '), equals('foo  \r\n\t   '));
  });

  test('trim characters from left side of the input', () {
    expect(s.ltrim('010100201000', '01'), equals('201000'));
  });

  test('trim whitespace from the right side of the input', () {
    expect(s.rtrim('  \r\n\tfoo  \r\n\t   '), equals('  \r\n\tfoo'));
  });

  test('trim characters from right side of the input', () {
    expect(s.rtrim('010100201000', '01'), equals('0101002'));
  });

  test('remove characters that do not appear in the whitelist', () {
    expect(s.whitelist('abcdef', 'abc'), equals('abc'));
    expect(s.whitelist('aaaaaaaaaabbbbbbbbbb', 'abc'), equals('aaaaaaaaaabbbbbbbbbb'));
    expect(s.whitelist('a1b2c3', 'abc'), equals('abc'));
    expect(s.whitelist('   ', 'abc'), equals(''));
  });

  test('remove characters that appear in the blacklist', () {
    expect(s.blacklist('abcdef', 'abc'), equals('def'));
    expect(s.blacklist('aaaaaaaaaabbbbbbbbbb', 'abc'), equals(''));
    expect(s.blacklist('a1b2c3', 'abc'), equals('123'));
    expect(s.blacklist('   ', 'abc'), equals('   '));
  });

  test('remove characters with a numerical value < 32 and 127 (perserve new lines)', () {
    expect(s.stripLow('foo\x0A\x0D', true), equals('foo\x0A\x0D'));
    expect(s.stripLow('\x03foo\x0A\x0D', true), equals('foo\x0A\x0D'));
  });

  test('remove characters with a numerical value < 32 and 127', () {
    expect(s.stripLow('foo\x00'), equals('foo'));
    expect(s.stripLow('\x7Ffoo\x02'), equals('foo'));
    expect(s.stripLow('\x01\x09'), equals(''));
    expect(s.stripLow('foo\x0A\x0D'), equals('foo'));
    expect(s.stripLow('perch\u00e9'), equals('perch\u00e9'));
    expect(s.stripLow('\u20ac'), equals('\u20ac'));
    expect(s.stripLow('\u2206\x0A'), equals('\u2206'));
  });

  test('replace `<`, `>`, `&`, `\'` and `"` with HTML entities', () {
    expect(s.escape('<img alt="foo&bar">'), equals('&lt;img alt=&quot;foo&amp;bar&quot;&gt;'));
    expect(s.escape("<img alt='foo&bar'>"), equals('&lt;img alt=&#x27;foo&amp;bar&#x27;&gt;'));
  });

  test('canonicalize an email address', () {
    expect(s.normalizeEmail('test@me.com'), equals('test@me.com'));
    expect(s.normalizeEmail('some.name@gmail.com'), equals('somename@gmail.com'));
    expect(s.normalizeEmail('some.name@googleMail.com'), equals('somename@gmail.com'));
    expect(s.normalizeEmail('some.name+extension@gmail.com'), equals('somename@gmail.com'));
    expect(s.normalizeEmail('some.Name+extension@GoogleMail.com'), equals('somename@gmail.com'));
    expect(s.normalizeEmail('some.name.middleName+extension@gmail.com'), equals('somenamemiddlename@gmail.com'));
    expect(s.normalizeEmail('some.name.midd.leNa.me.+extension@gmail.com'), equals('somenamemiddlename@gmail.com'));
    expect(s.normalizeEmail('some.name.midd.leNa.me.+extension@GoogleMail.com'), equals('somenamemiddlename@gmail.com'));
    expect(s.normalizeEmail('some.name+extension@unknown.com'), equals('some.name+extension@unknown.com'));
    expect(s.normalizeEmail('hans@m端ller.com'), equals('hans@m端ller.com'));
    expect(s.normalizeEmail('an invalid email address'), equals(''));
    expect(s.normalizeEmail(''), equals(''));
  });

  test('canonicalize an email address with lowercase false', () {
    expect(s.normalizeEmail('test@me.com', {'lowercase': false}), equals('test@me.com'));
    expect(s.normalizeEmail('hans@m端ller.com', {'lowercase': false}), equals('hans@m端ller.com'));
    expect(s.normalizeEmail('test@ME.COM', {'lowercase': false}), equals('test@me.com'));
    expect(s.normalizeEmail('TEST@me.com', {'lowercase': false}), equals('TEST@me.com'));
    expect(s.normalizeEmail('TEST@ME.COM', {'lowercase': false}), equals('TEST@me.com'));
    expect(s.normalizeEmail('blAH@x.com', {'lowercase': false}), equals('blAH@x.com'));
    expect(s.normalizeEmail('SOME.name@GMAIL.com', {'lowercase': false}), equals('somename@gmail.com'));
    expect(s.normalizeEmail('SOME.name.middleName+extension@GoogleMail.com', {'lowercase': false}), equals('somenamemiddlename@gmail.com'));
    expect(s.normalizeEmail('SOME.name.midd.leNa.me.+extension@gmail.com', {'lowercase': false}), equals('somenamemiddlename@gmail.com'));
  });
}
