import 'package:english_club/features/manage_grades_and_classes/ui/widgets/_AddGradeButton.dart';
import 'package:flutter/material.dart';

class NoGradesFoundWidget extends StatelessWidget {
  final VoidCallback onCreateGrade;

  const NoGradesFoundWidget({required this.onCreateGrade, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(child: Text('No grades found. Click below to add one.')),
        const SizedBox(height: 20),
        AddGradeButton(onCreateGrade: onCreateGrade),
      ],
    );
  }
}
