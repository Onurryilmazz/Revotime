// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'RevoTime';

  @override
  String get login => 'Login';

  @override
  String get welcome => 'Welcome';

  @override
  String get loginSubtitle => 'Please login to continue';

  @override
  String get email => 'Email';

  @override
  String get emailHint => 'example@email.com';

  @override
  String get emailRequired => 'Please enter your email address';

  @override
  String get emailInvalid => 'Please enter a valid email address';

  @override
  String get loginError => 'Login failed. Please try again.';

  @override
  String get generalError => 'An error occurred. Please try again.';

  @override
  String get codeVerificationTitle => 'Verify Code';

  @override
  String get enterCode => 'Please enter the code';

  @override
  String codeSentTo(String email) {
    return 'We sent a 6-digit code to $email.';
  }

  @override
  String get verify => 'Verify';

  @override
  String get resendCode => 'Resend Code';

  @override
  String get codeResentMessage => 'Code resent successfully.';

  @override
  String get reminderGroups => 'Reminder Groups';

  @override
  String get payments => 'Payments';

  @override
  String get events => 'Events';

  @override
  String get work => 'Work';

  @override
  String get personal => 'Personal';

  @override
  String get health => 'Health';

  @override
  String get education => 'Education';

  @override
  String get shopping => 'Shopping';

  @override
  String get social => 'Social';

  @override
  String reminderCount(int count) {
    return '$count reminders';
  }

  @override
  String get upcomingReminders => 'Upcoming Reminders';

  @override
  String get pastReminders => 'Past Reminders';

  @override
  String get upcoming => 'Upcoming';

  @override
  String get past => 'Past';

  @override
  String get addReminder => 'Add Reminder';

  @override
  String get rentPayment => 'Rent Payment';

  @override
  String get doctorAppointment => 'Doctor Appointment';

  @override
  String get meeting => 'Meeting';
}
