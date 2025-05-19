import 'package:flutter/material.dart';

class Reminder {
  final String id;
  final String title;
  final String description;
  final DateTime dateTime;
  final bool isCompleted;
  final List<String> sharedWith;

  Reminder({
    required this.id,
    required this.title,
    required this.description,
    required this.dateTime,
    required this.isCompleted,
    required this.sharedWith,
  });

  factory Reminder.fromJson(Map<String, dynamic> json) {
    return Reminder(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String), // Assuming ISO 8601 string
      isCompleted: json['isCompleted'] as bool,
      sharedWith: List<String>.from(json['sharedWith'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'dateTime': dateTime.toIso8601String(),
      'isCompleted': isCompleted,
      'sharedWith': sharedWith,
    };
  }

  // Helper method for updating completion status locally
  Reminder copyWith({bool? isCompleted}) {
    return Reminder(
      id: id,
      title: title,
      description: description,
      dateTime: dateTime,
      isCompleted: isCompleted ?? this.isCompleted,
      sharedWith: sharedWith,
    );
  }
} 