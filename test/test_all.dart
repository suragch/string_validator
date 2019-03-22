import 'package:test/test.dart';

import 'validator_test.dart' as validator;
import 'sanitizer_test.dart' as sanitizer;

void main() {
  group('validator', validator.main);
  group('sanitizer', sanitizer.main);
}