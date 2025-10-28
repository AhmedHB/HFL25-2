// lib/helpers/string_helper.dart

//----------------------------------
// Methods
//----------------------------------
String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1).toLowerCase();
}

String cleanNull(String? value) {
  if (value == null ||
      value.trim().isEmpty ||
      value.trim().toLowerCase() == 'null') {
    return 'N/A';
  }
  return value;
}
