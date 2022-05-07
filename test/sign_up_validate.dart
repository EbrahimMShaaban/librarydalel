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

  test('pasword dosen\'t exist show error message', () {

    final result = PasswordValidator.passVal('');
    expect(result, 'الرجاء إدخال كلمة مرور');
  });


}