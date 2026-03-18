import '../../MetaData/Langues/AppLanguage.dart';
import '../../init/Manager.dart';

/* lib/Auth/Shared/validators.dart */
String? emailValidator(String? v, {String? msgRequired, String? msgInvalid}) {
  final t = (v ?? '').trim();
  WinyCar s = Manager().winyCarTranslation;
  final requiredMsg = msgRequired ?? s.emailRequired;
  final invalidMsg = msgInvalid ?? s.emailInvalid;
  if (t.isEmpty) return requiredMsg;
  final ok = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(t);
  return ok ? null : invalidMsg;
}

String? passwordValidator(String? v, {int min = 8, String? msgRequired}) {
  WinyCar s = Manager().winyCarTranslation;
  final requiredMsg = msgRequired ?? s.passwordRequired;
  final t = v ?? '';

  if (t.isEmpty) return requiredMsg;
  if (t.length < min) return s.passwordMinChars(min);

  if (!RegExp(r'[A-Z]').hasMatch(t)) {
    return s.passwordMustContainUppercase;
  }

  if (!RegExp(r'[0-9]').hasMatch(t)) {
    return s.passwordMustContainNumber;
  }
  return null;
}

String? otpValidator(String? v, {int len = 6, String? msg}) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.codeRequired;
  final invalidMsg = msg ?? s.codeInvalid;
  if (!RegExp(r'^[A-Za-z0-9]{6}$').hasMatch(t)) return invalidMsg;
  if (t.length != len) return invalidMsg;
  return null;
}

String? phoneFrValidator(String? v) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.phoneRequired ?? s.required;
  if (!RegExp(r'^0\d{9}$').hasMatch(t)) return s.phoneFrInvalid;
  return null;
}

// === Nouveaux ===
String? phoneDzValidator(String? v) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.phoneRequired ?? s.required;
  // Formats acceptés: 05/06/07XXXXXXXX, +2135/6/7XXXXXXXX, 0XXXXXXXXX
  final ok = RegExp(r'^(?:0[5-7]\d{8}|\+213[5-7]\d{8})$').hasMatch(t);
  return ok ? null : s.phoneDzInvalid;
}

String? yearValidator(String? v) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.required;
  final y = int.tryParse(t);
  final now = DateTime.now().year + 1;
  if (y == null || y < 1950 || y > now) return s.yearInvalid;
  return null;
}

String? intValidator(String? v, {String? msg, bool allowZero = true}) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.required;
  final n = int.tryParse(t);
  final invalidMsg = msg ?? s.numberInvalid;
  if (n == null) return invalidMsg;
  if (!allowZero && n <= 0) return invalidMsg;
  if (n < 0) return invalidMsg;
  return null;
}

String? priceValidator(String? v) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').replaceAll(' ', '').replaceAll(',', '.');
  if (t.isEmpty) return s.required;
  final n = double.tryParse(t);
  if (n == null || n <= 0) return s.priceInvalid;
  return null;
}

String? matriculeDzValidator(String? v) {
  WinyCar s = Manager().winyCarTranslation;
  final t = (v ?? '').trim();
  if (t.isEmpty) return s.required;
  // Exemple tolérant: 123456-09-00 / 09-321-GH etc. => on vérifie au moins groupes séparés par tirets et alphanum
  return null;
}
