import 'package:flutter/material.dart';

class AddGradeButton extends StatelessWidget {
  final VoidCallback onCreateGrade;

  const AddGradeButton({required this.onCreateGrade, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onCreateGrade,
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
