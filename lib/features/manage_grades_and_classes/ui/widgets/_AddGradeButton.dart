import 'package:flutter/material.dart';

// ✅ ويدجت لزر "Add New Grade +"
class AddGradeButton extends StatelessWidget {
  final VoidCallback onCreateGrade; // دالة يتم استدعاؤها عند الضغط على الزر

  const AddGradeButton({required this.onCreateGrade, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onCreateGrade, // استدعاء الدالة الممررة
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepPurple,
          shape: const StadiumBorder(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          elevation: 4,
        ),
        child: const Text(
          'Add New Grade +',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
