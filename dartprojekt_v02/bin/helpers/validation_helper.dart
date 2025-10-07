// helpers/validation_helper.dart

String validateNumber(int number, int min, int max) {
  if (number < min) {
    return 'Number must be at least $min.';
  } else if (number > max) {
    return 'Number must not exceed $max.';
  } else {
    return 'Valid';
  }
}

bool isValidType(String type, List<String> validTypes) {
  return validTypes.contains(type);
}