import 'dart:math';
import 'dart:io';
import 'package:petitparser/petitparser.dart';

Parser buildParser() {
  final builder = ExpressionBuilder();
  builder.group()
    ..primitive((pattern('+-').optional() &
            digit().plus() &
            (char('.') & digit().plus()).optional() &
            (pattern('eE') & pattern('+-').optional() & digit().plus())
                .optional())
        .flatten('number expected')
        .trim()
        .map(num.tryParse))
    ..wrapper(
        char('(').trim(), char(')').trim(), (left, value, right) => value);
  builder.group()..prefix(char('-').trim(), (op, a) => -a);
  builder.group()..right(char('^').trim(), (a, op, b) => pow(a, b));
  builder.group()
    ..left(char('*').trim(), (a, op, b) => a * b)
    ..left(char('/').trim(), (a, op, b) => a / b);
  builder.group()
    ..left(char('+').trim(), (a, op, b) => a + b)
    ..left(char('-').trim(), (a, op, b) => a - b);
  return builder.build().end();
}

double calcString(String text) {
  final parser = buildParser();
  final input = text;
  final result = parser.parse(input);
  if (result.isSuccess)
    return result.value.toDouble();
  else
    return double.parse(text);
}

void main() {

  final expressions = [
    '10*5+4/2-1',
    /*51*/
    '(10*3-5)/5',
    /*5*/
    '3*10+15/(3+2)' /*33*/
  ];
  for (final expression in expressions) {
    print("'$expression' -> ${calcString(expression)}");
  }
  print("Enter expression");
  String? code_lang = stdin.readLineSync();
  var result = calcString(code_lang!);
  print("Result expression -> $result");
}
