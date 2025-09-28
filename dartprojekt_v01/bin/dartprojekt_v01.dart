import 'package:args/args.dart';

import 'dart:io';

const String version = '0.0.1';

ArgParser buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'verbose',
      abbr: 'v',
      negatable: false,
      help: 'Show additional command output.',
    )
    ..addFlag('version', negatable: false, help: 'Print the tool version.');
}

void printUsage(ArgParser argParser) {
  print('''
dartprojekt_v01 – En enkel kalkylator för + och -

Usage:
  dart dartprojekt_v01.dart [options]

Alternativ:
${argParser.usage}

Exempel:
  dart dartprojekt_v01.dart --help
  dart dartprojekt_v01.dart --version

När programmet körs:
  - Du blir ombedd att skriva in två tal (heltal eller decimaltal).
  - Du väljer en operator (+ eller -).
  - Resultatet skrivs ut.
''');
}

double readNumber(String prompt) {
  while (true) {
    stdout.write('$prompt: ');
    String? input = stdin.readLineSync();
    double? number = double.tryParse(input ?? '');
    if (number != null) return number;
    print('Fel: Ange ett giltigt tal (heltal eller decimaltal).');
  }
}

String readOperator(String prompt) {
  while (true) {
    stdout.write('$prompt (+, -): ');
    String? input = stdin.readLineSync();
    if (input != null && ['+', '-'].contains(input)) {
      return input;
    }
    print('Fel: Ange en giltig operator.');
  }
}

double calculate(double valueOne, double valueTwo, String operator){
  if (operator == '+') {
    return valueOne + valueTwo;
  } else if (operator == '-') {
    return valueOne - valueTwo;
  } else {
    throw ArgumentError('Ogiltig operator: $operator');
  }
}

void main(List<String> arguments) {
  final ArgParser argParser = buildParser();
  try {
    final ArgResults results = argParser.parse(arguments);
    bool verbose = false;

    // Process the parsed arguments.
    if (results.flag('help')) {
      printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      print('dartprojekt_v01 version: $version');
      return;
    }
    if (results.flag('verbose')) {
      verbose = true;
    }

    // Run main logic
    double firstNumber = readNumber('Ange första talet');
    print('Du angav: $firstNumber');
    double secondNumber = readNumber('Ange andra talet');
    print('Du angav: $secondNumber');
    String op = readOperator('Ange en operator');
    print('Du angav operatorn: $op');
    double result = calculate(firstNumber, secondNumber, op);
    print('$firstNumber $op $secondNumber = $result');

    // Print debugging
    if (verbose) {
      print('[DEBUG] firstNumber=$firstNumber, secondNumber=$secondNumber, operator=$op');
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    print(e.message);
    print('');
    printUsage(argParser);
  }
}
