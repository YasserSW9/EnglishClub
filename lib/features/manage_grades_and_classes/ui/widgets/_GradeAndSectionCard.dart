import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/features/manage_grades_and_classes/data/models/grades_response.dart'; // لاستخدام Data و Classes models

// ✅ ويدجت لبطاقة الصف والأقسام
class GradeAndSectionCard extends StatelessWidget {
  final Data grade; // بيانات الصف
  final TextEditingController
  textController; // كنترولر للتعديل (يتم تمريره من الأب)
  final Function(Data) onGradeDeleted; // callback للحذف
  final Function(Classes, int)
  onSectionDeleted; // callback لحذف القسم (يحتاج ID الصف)
  final Function(Data, String) onGradeNameEdited; // callback لتعديل اسم الصف
  final Function(Classes, String, int)
  onSectionNameEdited; // callback لتعديل اسم القسم (يحتاج ID القسم و ID الصف)

  const GradeAndSectionCard({
    required this.grade,
    required this.textController,
    required this.onGradeDeleted,
    required this.onSectionDeleted,
    required this.onGradeNameEdited,
    required this.onSectionNameEdited,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // ✅ حماية إضافية: تأكد أن grade ليس null
    if (grade == null) return const SizedBox.shrink(); // لا تعرض إذا كان null

    final List<Classes> sections = grade.classes ?? [];

    return Container(
      margin: const EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.deepPurple.shade100, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // زر تعديل اسم الصف
                GestureDetector(
                  onTap: () {
                    textController.text = grade.name ?? '';
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.info,
                      animType: AnimType.scale,
                      title: 'Edit Grade Name',
                      body: Padding(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: textController,
                          decoration: InputDecoration(
                            labelText: 'Grade Name',
                            hintText: 'New name for "${grade.name ?? ''}"',
                            border: const OutlineInputBorder(),
                            filled: true,
                            fillColor: Colors.grey[100],
                          ),
                        ),
                      ),
                      btnOkText: 'Save',
                      btnCancelText: 'Cancel',
                      btnOkOnPress: () {
                        final String newName = textController.text.trim();
                        if (newName.isEmpty) return;
                        onGradeNameEdited(grade, newName); // استدعاء callback
                        textController.clear();
                      },
                      btnCancelOnPress: () => textController.clear(),
                    ).show();
                  },
                  child: const Icon(Icons.edit, color: Colors.blue, size: 20),
                ),
                // عرض اسم الصف
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    grade.name ?? '', // ✅ استخدام ?? '' للحماية
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                // زر حذف الصف
                GestureDetector(
                  onTap: () {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.error,
                      title: 'Delete Grade',
                      desc:
                          'Are you sure you want to delete "${grade.name ?? ''}"? This action cannot be undone.', // ✅ استخدام ?? '' للحماية
                      btnOkText: 'Delete',
                      btnCancelText: 'Cancel',
                      btnOkOnPress: () {
                        onGradeDeleted(grade); // استدعاء callback
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.success,
                          title: 'Deleted!',
                          desc:
                              '"${grade.name ?? ''}" has been successfully removed.', // ✅ استخدام ?? '' للحماية
                          btnOkOnPress: () {},
                        ).show();
                      },
                    ).show();
                  },
                  child: const Icon(Icons.delete, color: Colors.red, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 10),
            // عرض الأقسام (إن وجدت)
            if (sections.isNotEmpty)
              for (
                int sectionIndex = 0;
                sectionIndex < sections.length;
                sectionIndex++
              )
                Dismissible(
                  key: ValueKey(
                    '${grade.id ?? 0}_${sections[sectionIndex].id ?? sectionIndex}',
                  ), // ✅ استخدام ?? 0 للحماية
                  direction: DismissDirection.horizontal,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.blue,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.error,
                        title: 'Delete Section',
                        desc:
                            'Are you sure you want to delete "${sections[sectionIndex].name ?? ''}"? This cannot be undone.', // ✅ استخدام ?? '' للحماية
                        btnOkText: 'Delete',
                        btnCancelText: 'Cancel',
                        btnOkOnPress: () {
                          onSectionDeleted(
                            sections[sectionIndex],
                            grade.id ?? 0,
                          ); // استدعاء callback
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            title: 'Deleted!',
                            desc:
                                '"${sections[sectionIndex].name ?? ''}" has been removed.', // ✅ استخدام ?? '' للحماية
                            btnOkOnPress: () {},
                          ).show();
                        },
                      ).show();
                      return false;
                    } else if (direction == DismissDirection.endToStart) {
                      textController.text = sections[sectionIndex].name ?? '';
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.scale,
                        title: 'Edit Section Name',
                        body: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: textController,
                            decoration: InputDecoration(
                              labelText: 'Section Name',
                              hintText:
                                  'New name for "${sections[sectionIndex].name ?? ''}"', // ✅ استخدام ?? '' للحماية
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        ),
                        btnOkText: 'Save',
                        btnCancelText: 'Cancel',
                        btnOkOnPress: () {
                          final String newSectionName = textController.text
                              .trim();
                          if (newSectionName.isEmpty) return;
                          onSectionNameEdited(
                            sections[sectionIndex],
                            newSectionName,
                            grade.id ?? 0,
                          ); // استدعاء callback
                          textController.clear();
                        },
                        btnCancelOnPress: () => textController.clear(),
                      ).show();
                      return false;
                    }
                    return false;
                  },
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Text(
                      sections[sectionIndex].name ??
                          '', // ✅ استخدام ?? '' للحماية
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
