import '../models/reminder.dart';

class ReminderService {
  // This is a mock service. In a real app, this would interact with a backend.
  
  // Mock list of reminders
  final List<Reminder> _mockReminders = [
    Reminder(
      id: '1',
      title: 'Kira Ödemesi',
      description: 'Aylık kira ödemesi',
      dateTime: DateTime.now().add(const Duration(days: 1)),
      isCompleted: false,
      sharedWith: ['friend1@example.com'],
    ),
    Reminder(
      id: '2',
      title: 'Doktor Randevusu',
      description: 'Kontrol randevusu',
      dateTime: DateTime.now().add(const Duration(days: 2)),
      isCompleted: false,
      sharedWith: [],
    ),
    Reminder(
      id: '3',
      title: 'Toplantı',
      description: 'Proje toplantısı',
      dateTime: DateTime.now().add(const Duration(days: 3)),
      isCompleted: true,
      sharedWith: ['colleague1@example.com', 'colleague2@example.com'],
    ),
  ];

  Future<List<Reminder>> getReminders() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    // In a real app, filter by upcoming/past here based on DateTime.now()
    return _mockReminders;
  }

  Future<void> createReminder(Reminder reminder) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _mockReminders.add(reminder);
    print('Mock Reminder Created: ${reminder.title}');
  }

  Future<void> updateReminder(Reminder reminder) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockReminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _mockReminders[index] = reminder;
      print('Mock Reminder Updated: ${reminder.title}');
    }
  }

  Future<void> deleteReminder(String reminderId) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _mockReminders.removeWhere((r) => r.id == reminderId);
    print('Mock Reminder Deleted: $reminderId');
  }

  Future<void> toggleReminderCompletion(String reminderId, {bool? isCompleted}) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _mockReminders.indexWhere((r) => r.id == reminderId);
    if (index != -1) {
      final currentReminder = _mockReminders[index];
      _mockReminders[index] = currentReminder.copyWith(
        isCompleted: isCompleted ?? !currentReminder.isCompleted,
      );
      print('Mock Reminder ${isCompleted == true ? 'Marked Completed' : isCompleted == false ? 'Marked Incomplete' : 'Completion Toggled'}: ${_mockReminders[index].title}');
    }
  }
} 