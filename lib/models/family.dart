import 'package:flutter/material.dart';

class Family {
  final String id;
  final String title;
  final Color color;

  const Family({
    required this.id,
    required this.title,
    this.color = Colors.orange,
  });
}