import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/core/helpers/extensions.dart';

class ManageGradesAndClasses extends StatefulWidget {
  @override
  _ManageGradesAndClassesState createState() => _ManageGradesAndClassesState();
}

class _ManageGradesAndClassesState extends State<ManageGradesAndClasses> {
  final TextEditingController _textController = TextEditingController();

  List _grades = [
    {
      'name': 'Temporary',
      'sections': ['temp1'],
    },
    {
      'name': 'Grade 7',
      'sections': ['sec 1', 'sec 2', 'sec 3', 'sec 4'],
    },
    {
      'name': 'Grade 8',
      'sections': ['sec 1', 'sec 2'],
    },
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F1FA),
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Manage Grades & Classes',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                _textController.clear();
                AwesomeDialog(
                  context: context,

                  dialogType: DialogType.question,
                  animType: AnimType.bottomSlide,
                  title: "Add New Grade",
                  body: Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        labelText: 'Grade Name',
                        hintText: 'e.g., Grade 10',
                        border: OutlineInputBorder(),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  btnOkText: 'Add',
                  btnCancelText: 'Cancel',
                  btnOkOnPress: () {
                    final String newName = _textController.text.trim();
                    if (newName.isEmpty) return;
                    setState(() {
                      _grades.add({
                        'name': newName,
                        'sections': ["sec1"],
                      });
                    });
                    _textController.clear();
                  },
                  btnCancelOnPress: () => _textController.clear(),
                )..show();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: const StadiumBorder(),
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 12,
                ),
                elevation: 4,
              ),
              child: const Text(
                'Add New Grade +',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 20),
          for (int gradeIndex = 0; gradeIndex < _grades.length; gradeIndex++)
            Builder(
              builder: (context) {
                final Map<String, dynamic> grade = _grades[gradeIndex];

                return Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.deepPurple.shade100,
                      width: 1,
                    ),
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
                            GestureDetector(
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.scale,
                                  title: 'Edit Grade Name',
                                  body: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextField(
                                      controller: _textController,
                                      decoration: InputDecoration(
                                        labelText: 'Grade Name',
                                        hintText:
                                            'New name for "${grade['name']}"',
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                  btnOkText: 'Save',
                                  btnCancelText: 'Cancel',
                                  btnOkOnPress: () {
                                    final String newName = _textController.text
                                        .trim();
                                    if (newName.isEmpty) return;
                                    setState(() {
                                      _grades[gradeIndex]['name'] = newName;
                                    });
                                    _textController.clear();
                                  },
                                  btnCancelOnPress: () =>
                                      _textController.clear(),
                                )..show();
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.blue,
                                size: 20,
                              ),
                            ),
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
                                grade['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  title: 'Delete Grade',
                                  desc:
                                      'Are you sure you want to delete "${grade['name']}"? This action cannot be undone.',
                                  btnOkText: 'Delete',
                                  btnCancelText: 'Cancel',
                                  btnOkOnPress: () {
                                    setState(
                                      () => _grades.removeAt(gradeIndex),
                                    );
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      title: 'Deleted!',
                                      desc:
                                          '"${grade['name']}" has been successfully removed.',
                                      btnOkOnPress: () {},
                                    )..show();
                                  },
                                )..show();
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        for (
                          int sectionIndex = 0;
                          sectionIndex < grade['sections'].length;
                          sectionIndex++
                        )
                          Dismissible(
                            key: ValueKey(
                              '${grade['name']}_${grade['sections'][sectionIndex]}_$sectionIndex',
                            ),
                            direction: DismissDirection.horizontal,
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 20),
                              child: const Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                            ),
                            secondaryBackground: Container(
                              color: Colors.blue,
                              alignment: Alignment.centerRight,
                              padding: const EdgeInsets.only(right: 20),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.error,
                                  title: 'Delete Section',
                                  desc:
                                      'Are you sure you want to delete "${grade['sections'][sectionIndex]}"? This cannot be undone.',
                                  btnOkText: 'Delete',
                                  btnCancelText: 'Cancel',
                                  btnOkOnPress: () {
                                    setState(() {
                                      grade['sections'].removeAt(sectionIndex);
                                    });
                                    AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.success,
                                      title: 'Deleted!',
                                      desc:
                                          '"${grade['sections'][sectionIndex]}" has been removed.',
                                      btnOkOnPress: () {},
                                    )..show();
                                  },
                                )..show();
                                return false;
                              } else if (direction ==
                                  DismissDirection.endToStart) {
                                _textController.text =
                                    grade['sections'][sectionIndex];
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.scale,
                                  title: 'Edit Section Name',
                                  body: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: TextField(
                                      controller: _textController,
                                      decoration: InputDecoration(
                                        labelText: 'Section Name',
                                        hintText:
                                            'New name for "${grade['sections'][sectionIndex]}"',
                                        border: const OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ),
                                  btnOkText: 'Save',
                                  btnCancelText: 'Cancel',
                                  btnOkOnPress: () {
                                    final String newSectionName =
                                        _textController.text.trim();
                                    if (newSectionName.isEmpty) return;
                                    setState(() {
                                      grade['sections'][sectionIndex] =
                                          newSectionName;
                                    });
                                    _textController.clear();
                                  },
                                  btnCancelOnPress: () =>
                                      _textController.clear(),
                                )..show();
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
                                grade['sections'][sectionIndex],
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
              },
            ),
        ],
      ),
    );
  }
}
