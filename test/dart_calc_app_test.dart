import 'package:dart_calc_app/dart_calc_app.dart';
import 'package:test/test.dart';

void main() {
  group("Fixed tests", () {
    test("calcString('10*5+4/2-1')",
        () => expect(calcString('10*5+4/2-1'), equals(51)));
    test("calcString('(10*3-5)/5')",
        () => expect(calcString('(10*3-5)/5'), equals(5)));
    test("calcString('3*10+15/(3+2)')",
        () => expect(calcString('3*10+15/(3+2)'), equals(33)));
  });
}
