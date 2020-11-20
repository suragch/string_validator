import 'package:string_validator/string_validator.dart';

void main() {
  String userInput = 'http://localhost:61500this is an invalid url!!!!';
  bool isValid = isURL(userInput); // false
  print(isValid);

  userInput = 'me@example.com';
  isValid = isEmail(userInput); // true
  print(isValid);

  userInput = 'password1';
  isValid = isLength(userInput, 12); // false
  print(isValid);
}
