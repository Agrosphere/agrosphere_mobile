import 'package:flutter/material.dart';

Widget category(String category) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    decoration: BoxDecoration(
      color: Colors.blueAccent.withOpacity(0.1),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      category,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.blueAccent,
      ),
    ),
  );
}
