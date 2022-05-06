import 'package:flutter_test/flutter_test.dart';
import 'package:librarydalel/screens/registration/sign_in_screen.dart';

void main() {
  test('Name dosen\'t exist show error message', () {

    final result = NameValidator.nameVal('');
    expect(result, 'برجاءادخال الاسم');
  });

  test('Name less than 3 letters return error message', () {

    final result = NameValidator.nameVal('ar');
    expect(result, 'يجب أن يتكون الاسم من 3 أحرف على الاقل');
  });
  test('email when not contain @ return error message', () {

    final result = EmailValidator.emailVal('ebraim.gmail');
    expect(result, 'يجب  أن يحتوي البريد الايكتروني على @');
  });
  test('email dosen\'t exist show error message', () {

    final result = EmailValidator.emailVal('');
    expect(result, 'الرجاء إدخال بريد الكتروني');
  });
  test('email dosen\'t exist show error message', () {

    final result = EmailValidator.emailVal('');
    expect(result, 'الرجاء إدخال بريد الكتروني');
  });

  // test('non-empty email returns null', () {
  //
  //   final result = EmailFieldValidator.validate('email');
  //   expect(result, null);
  // });
  //
  // test('empty password returns error string', () {
  //
  //   final result = PasswordFieldValidator.validate('');
  //   expect(result, 'Password can\'t be empty');
  // });
  //
  // test('non-empty password returns null', () {
  //
  //   final result = PasswordFieldValidator.validate('password');
  //   expect(result, null);
  // });
}