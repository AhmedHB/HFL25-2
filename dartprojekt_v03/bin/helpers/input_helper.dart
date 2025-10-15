// helpers/input_helper.dart

import 'dart:io';

// helper
import 'validation_helper.dart';
import 'string_helper.dart';

//----------------------------------
// Methods
//----------------------------------
int readNumber(String prompt, int min, int max) {
  while (true) {
    stdout.write('$prompt: ');
    String? input = stdin.readLineSync();
    int? number = int.tryParse(input ?? '');
    if (number != null && validateNumber(number, min, max) == 'Valid') return number;
    print('Fel: Ange ett giltigt alternativ (heltal).');
  }
}

String readString(String prompt, List<String> validTypes, bool validation) {
  while (true) {
    stdout.write('$prompt: ');
    String? input = stdin.readLineSync();
    if (input != null && validation && isValidType(capitalizeFirstLetter(input), validTypes)) {
      input = capitalizeFirstLetter(input);
      return input;
    }else if(input != null && !validation){
      input = capitalizeFirstLetter(input);
      return input;
    }
    if(!validation) {
      print('[Input_Helper] Fel: oväntat fel.');
    }else{
      String types =validTypes.join(', ');
      print('[Input_Helper] Fel: validerings fel. Ange något av dem korrekta alternativen: $types');
    }
  }
}
