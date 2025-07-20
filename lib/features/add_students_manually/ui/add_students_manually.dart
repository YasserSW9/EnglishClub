// lib/features/add_students_manually/ui/screens/add_students_manually.dart
import 'package:english_club/features/add_students_manually/logic/create_student_cubit.dart';
import 'package:english_club/features/add_students_manually/logic/create_student_state.dart';
import 'package:english_club/features/add_students_manually/ui/widgets/custom_dropdown_field.dart';
import 'package:english_club/features/add_students_manually/ui/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddStudentsManually extends StatefulWidget {
  const AddStudentsManually({super.key});

  @override
  _AddStudentsManuallyState createState() => _AddStudentsManuallyState();
}

class _AddStudentsManuallyState extends State<AddStudentsManually> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedClassType;
  String? _selectedGradeType;
  String? _selectedOxfordDominoes;
  String? _selectedOxfordReadDiscover;
  String? _selectedNationalGeographic;
  String? _selectedListeningSkill;

  final List<String> _classTypes = ['temp1'];
  final List<String> _gradeTypes = [
    'Temporary',
    'Grade 7',
    'Grade 8',
    'Grade 9',
    'Grade 10',
  ];
  final List<String> _oxfordDominoesOptions = [
    'Quick Starter Part 1/D&B',
    'Quick Starter Part 2/D&B',
    'Starter Part 1/D&B',
    'Starter Part 2/D&B',
    'level 1 Part 1/D&B',
    'level 1 Part 2/D&B',
  ];
  final List<String> _oxfordReadDiscoverOptions = [
    'Level 1/R&D',
    'Level 2/R&D',
    'Level 3/R&D',
    'Level 4/R&D',
    'Level 5/R&D',
    'Level 6/R&D',
    'Extra Level /R&D',
  ];
  final List<String> _nationalGeographicOptions = [
    'A2 Part 1/N.G',
    'A2 Part 2/N.G',
    'B1 Part 1/N.G',
    'B1 Part 2/N.G',
    'B2/N.G',
    'C1/N.G',
  ];
  final List<String> _listeningSkillOptions = [
    'Begginers/L.S',
    'Elementary/L.S',
    'Intermediate/L.S',
    'Upper Intermediate/L.S',
    'Advanced/L.S',
  ];

  @override
  void initState() {
    super.initState();

    _selectedClassType = 'temp1';
    _selectedGradeType = 'Temporary';
    // تهيئة gClassIdController بالقيمة الافتراضية عند بدء التشغيل
    context.read<CreateStudentCubit>().gClassIdController.text =
        _getGradeId(_selectedGradeType)?.toString() ?? '';
  }

  @override
  void dispose() {
    super.dispose();
  }

  // دالة مساعدة لتحويل اسم الدرجة إلى ID رقمي بناءً على استجابة الـ API
  int? _getGradeId(String? gradeName) {
    switch (gradeName) {
      case 'Temporary':
        return 1; // ID 1 من الـ API
      case 'Grade 7':
        return 2; // ID 2 من الـ API
      case 'Grade 8':
        return 3; // ID 3 من الـ API
      case 'Grade 9':
        return 4; // ID 4 من الـ API
      case 'Grade 10':
        return 5; // ID 5 من الـ API
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final createStudentCubit = context.read<CreateStudentCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Create Student account',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF673AB7),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.all(25),
        color: Colors.white,
        child: BlocListener<CreateStudentCubit, CreateStudentState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Creating account...')),
                );
              },
              success: (data) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();

                // الوصول الصحيح للبيانات هو data.data?.account
                final username =
                    data.data?.account?.username ?? 'Not available';
                final password =
                    data.data?.account?.password ?? 'Not available';

                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.success,
                  animType: AnimType.rightSlide,
                  title: 'Account Created Successfully! 🎉',
                  desc: 'Username: $username\nPassword: $password',
                  btnOkOnPress: () {
                    // يمكنك إضافة أي منطق هنا عند إغلاق الـ dialog
                  },
                ).show();
              },
              error: (error) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Error: $error 😞')));
              },
            );
          },
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                CustomInputField(
                  controller: createStudentCubit.nameController,
                  labelText: 'Student name',
                  hintText: 'Student name',
                ),
                const SizedBox(height: 15.0),
                Row(
                  children: [
                    Expanded(
                      child: CustomDropdownField(
                        value: _selectedClassType,
                        hintText: "Class",
                        items: _classTypes,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedClassType = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: CustomDropdownField(
                        value: _selectedGradeType,
                        hintText: "Grade",
                        items: _gradeTypes,
                        onChanged: (newValue) {
                          setState(() {
                            _selectedGradeType = newValue;
                            // تحديث gClassIdController هنا عند تغيير الدرجة
                            createStudentCubit.gClassIdController.text =
                                _getGradeId(newValue)?.toString() ?? '';
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CustomInputField(
                  controller: createStudentCubit.scoreController,
                  labelText: 'Student score',
                  hintText: 'Student score',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomInputField(
                  controller: createStudentCubit.borrowLimitController,
                  labelText: 'Borrow limit',
                  hintText: 'Borrow limit',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomInputField(
                  controller: createStudentCubit.bronzeCoinsController,
                  labelText: 'Bronze coins',
                  hintText: 'Bronze coins',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomInputField(
                  controller: createStudentCubit.silverCoinsController,
                  labelText: 'Silver coins',
                  hintText: 'Silver coins',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 16.0),
                CustomInputField(
                  controller: createStudentCubit.goldenCoinsController,
                  labelText: 'Golden coins',
                  hintText: 'Golden coins',
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),

                CustomDropdownField(
                  value: _selectedOxfordDominoes,
                  hintText: 'OXFORD DOMINOES & BOOKWORMS Quick Starter Part',
                  items: _oxfordDominoesOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOxfordDominoes = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdownField(
                  value: _selectedOxfordReadDiscover,
                  hintText: 'OXFORD READ & DISCOVER 1-6 Level 1/R&D',
                  items: _oxfordReadDiscoverOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedOxfordReadDiscover = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdownField(
                  value: _selectedNationalGeographic,
                  hintText: 'NATIONAL GEOGRAPHIC A2 Part 1/N.G',
                  items: _nationalGeographicOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedNationalGeographic = newValue;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                CustomDropdownField(
                  value: _selectedListeningSkill,
                  hintText: 'LISTENING SKILL Begginers/L.S',
                  items: _listeningSkillOptions,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedListeningSkill = newValue;
                    });
                  },
                ),
                const SizedBox(height: 24.0),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // تأكيد أن gClassIdController لديه قيمة بناءً على الاختيار الحالي
                      createStudentCubit.gClassIdController.text =
                          _getGradeId(_selectedGradeType)?.toString() ?? '';

                      createStudentCubit.emitCreateStudentLoaded();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
