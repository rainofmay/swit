import 'package:flutter/material.dart';

class Task {
  final String id;
  String title;
  Color color;
  final bool isDefault;

  Task({
    required this.id,
    required this.title,
    required this.color,
    this.isDefault = false,
  });
}
