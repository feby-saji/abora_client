import 'package:flutter/material.dart';

class ConfirmBookingModel {
  final DateTime date;
  final String time;
  final String sessions;
  final String image;
  final String name;
  final String goal;

  ConfirmBookingModel({
    required this.time,
    required this.date,
    required this.sessions,
    required this.image,
    required this.name,
    required this.goal,
  });

  toMap() {
    return {
      'date': date,
      'image': image,
      'name': name,
      'time': time,
      'sessionCount': sessions,
      'goal': goal,
    };
  }
}
