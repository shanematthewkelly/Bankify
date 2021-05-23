import 'package:Bankify/screens/auth/login/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('empty email returns error', () {
    var testResult = EmailValidator.validate('');
    expect(testResult, 'Email is required');
  });

  test('Inputted email returns null', () {
    var testResult = EmailValidator.validate('email');
    expect(testResult, null);
  });

  test('empty password returns error', () {
    var testResult = PasswordValidator.validate('');
    expect(testResult, 'Password is required');
  });

  test('Inputted password returns null', () {
    var testResult = PasswordValidator.validate('password');
    expect(testResult, null);
  });
}
