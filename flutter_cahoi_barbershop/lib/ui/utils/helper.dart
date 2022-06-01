import 'package:logger/logger.dart';

bool validateUppercase(String text) {
  RegExp regex = RegExp(r'(?=.*[A-Z])');
  return !regex.hasMatch(text);
}

bool validateNumeric(String text) {
  RegExp regex = RegExp(r'(?=.*?[0-9])');
  return !regex.hasMatch(text);
}

Logger logger = Logger();
