// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appName => 'RevoTime';

  @override
  String get login => 'Giriş Yap';

  @override
  String get welcome => 'Hoş Geldiniz';

  @override
  String get loginSubtitle => 'Devam etmek için giriş yapın';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'ornek@email.com';

  @override
  String get emailRequired => 'Lütfen email adresinizi girin';

  @override
  String get emailInvalid => 'Lütfen geçerli bir email adresi girin';

  @override
  String get loginError => 'Giriş başarısız. Lütfen tekrar deneyin.';

  @override
  String get generalError => 'Bir hata oluştu. Lütfen tekrar deneyin.';

  @override
  String get codeVerificationTitle => 'Kodu Doğrula';

  @override
  String get enterCode => 'Lütfen kodu girin';

  @override
  String codeSentTo(String email) {
    return '$email adresinize 6 haneli bir kod gönderdik.';
  }

  @override
  String get verify => 'Doğrula';

  @override
  String get resendCode => 'Kodu Tekrar Gönder';

  @override
  String get codeResentMessage => 'Kod başarıyla yeniden gönderildi.';

  @override
  String get reminderGroups => 'Hatırlatıcı Grupları';

  @override
  String get payments => 'Ödemeler';

  @override
  String get events => 'Etkinlikler';

  @override
  String get work => 'İş';

  @override
  String get personal => 'Kişisel';

  @override
  String get health => 'Sağlık';

  @override
  String get education => 'Eğitim';

  @override
  String get shopping => 'Alışveriş';

  @override
  String get social => 'Sosyal';

  @override
  String reminderCount(int count) {
    return '$count hatırlatıcı';
  }

  @override
  String get upcomingReminders => 'Yaklaşan Hatırlatıcılar';

  @override
  String get pastReminders => 'Geçmiş Hatırlatıcılar';

  @override
  String get upcoming => 'Yaklaşan';

  @override
  String get past => 'Geçmiş';

  @override
  String get addReminder => 'Hatırlatıcı Ekle';

  @override
  String get rentPayment => 'Kira Ödemesi';

  @override
  String get doctorAppointment => 'Doktor Randevusu';

  @override
  String get meeting => 'Toplantı';
}
