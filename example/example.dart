import 'package:string_validator/string_validator.dart';

main() {
  String userInput = 'http://localhost:61500this is an invalid url!!!!';
  bool isValid = isURL(userInput); // false

  userInput = 'me@example.com';
  isValid = isEmail(userInput); // true

  userInput = 'password1';
  isValid = isLength(userInput, 12); // false
}
