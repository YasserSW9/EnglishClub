// add_students_manually.dart
import 'package:english_club/features/add_students_manually/ui/widgets/custom_dropdown_field.dart';
import 'package:english_club/features/add_students_manually/ui/widgets/custom_input_field.dart';
import 'package:flutter/material.dart';

class AddStudentsManually extends StatefulWidget {
  const AddStudentsManually({super.key});

  @override
  _AddStudentsManuallyState createState() => _AddStudentsManuallyState();
}

class _AddStudentsManuallyState extends State<AddStudentsManually> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentScoreController = TextEditingController();
  final TextEditingController _borrowLimitController = TextEditingController();
  final TextEditingController _bronzeCoinsController = TextEditingController();
  final TextEditingController _silverCoinsController = TextEditingController();
  final TextEditingController _goldenCoinsController = TextEditingController();

  String? _selectedClassType = 'temp1';
  String? _selectedGradeType = 'Temporary';
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
    'Elementary/L.S'
        'Intermediate/L.S',
    'Upper Intermediate/L.S',
    'Advanced/L.S',
  ];

  String? _studentNameError;
  String? _studentScoreError;
  String? _borrowLimitError;
  String? _bronzeCoinsError;
  String? _silverCoinsError;
  String? _goldenCoinsError;
  String? _classTypeError;
  String? _gradeTypeError;
  String? _oxfordDominoesError;
  String? _oxfordReadDiscoverError;
  String? _nationalGeographicError;
  String? _listeningSkillError;

  @override
  void dispose() {
    _studentNameController.dispose();
    _studentScoreController.dispose();
    _borrowLimitController.dispose();
    _bronzeCoinsController.dispose();
    _silverCoinsController.dispose();
    _goldenCoinsController.dispose();
    super.dispose();
  }

  bool _validateForm() {
    setState(() {
      _studentNameError = null;
      _studentScoreError = null;
      _borrowLimitError = null;
      _bronzeCoinsError = null;
      _silverCoinsError = null;
      _goldenCoinsError = null;
      _classTypeError = null;
      _gradeTypeError = null;
      _oxfordDominoesError = null;
      _oxfordReadDiscoverError = null;
      _nationalGeographicError = null;
      _listeningSkillError = null;
    });

    bool isValid = true;

    // قواعد التحقق من صحة حقول إدخال النص
    if (_studentNameController.text.isEmpty) {
      _studentNameError = 'Please enter student name';
      isValid = false;
    }
    if (_studentScoreController.text.isEmpty) {
      _studentScoreError = 'Please enter student score';
      isValid = false;
    } else if (int.tryParse(_studentScoreController.text) == null) {
      _studentScoreError = 'Please enter a valid number';
      isValid = false;
    }
    if (_borrowLimitController.text.isEmpty) {
      _borrowLimitError = 'Please enter borrow limit';
      isValid = false;
    } else if (int.tryParse(_borrowLimitController.text) == null) {
      _borrowLimitError = 'Please enter a valid number';
      isValid = false;
    }
    if (_bronzeCoinsController.text.isEmpty) {
      _bronzeCoinsError = 'Please enter bronze coins';
      isValid = false;
    } else if (int.tryParse(_bronzeCoinsController.text) == null) {
      _bronzeCoinsError = 'Please enter a valid number';
      isValid = false;
    }
    if (_silverCoinsController.text.isEmpty) {
      _silverCoinsError = 'Please enter silver coins';
      isValid = false;
    } else if (int.tryParse(_silverCoinsController.text) == null) {
      _silverCoinsError = 'Please enter a valid number';
      isValid = false;
    }
    if (_goldenCoinsController.text.isEmpty) {
      _goldenCoinsError = 'Please enter golden coins';
      isValid = false;
    } else if (int.tryParse(_goldenCoinsController.text) == null) {
      _goldenCoinsError = 'Please enter a valid number';
      isValid = false;
    }

    if (_selectedClassType == null) {
      _classTypeError = 'Please select a class type';
      isValid = false;
    }
    if (_selectedGradeType == null) {
      _gradeTypeError = 'Please select a grade type';
      isValid = false;
    }
    if (_selectedOxfordDominoes == null) {
      _oxfordDominoesError = 'Please select an option for Oxford Dominoes';
      isValid = false;
    }
    if (_selectedOxfordReadDiscover == null) {
      _oxfordReadDiscoverError =
          'Please select an option for Oxford Read & Discover';
      isValid = false;
    }
    if (_selectedNationalGeographic == null) {
      _nationalGeographicError =
          'Please select an option for National Geographic';
      isValid = false;
    }
    if (_selectedListeningSkill == null) {
      _listeningSkillError = 'Please select an option for Listening Skill';
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
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
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(25),
        color: Colors.white,

        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomInputField(
                controller: _studentNameController,
                labelText: 'Student name',
                hintText: 'Student name',
                errorText: _studentNameError,
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
                          _classTypeError = null;
                        });
                      },
                      errorText: _classTypeError,
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
                          _gradeTypeError = null; //
                        });
                      },
                      errorText: _gradeTypeError,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                controller: _studentScoreController,
                labelText: 'Student score',
                hintText: 'Student score',
                keyboardType: TextInputType.number,
                errorText: _studentScoreError,
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                controller: _borrowLimitController,
                labelText: 'Borrow limit',
                hintText: 'Borrow limit',
                keyboardType: TextInputType.number,
                errorText: _borrowLimitError,
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                controller: _bronzeCoinsController,
                labelText: 'Bronze coins',
                hintText: 'Bronze coins',
                keyboardType: TextInputType.number,
                errorText: _bronzeCoinsError,
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                controller: _silverCoinsController,
                labelText: 'Silver coins',
                hintText: 'Silver coins',
                keyboardType: TextInputType.number,
                errorText: _silverCoinsError,
              ),
              const SizedBox(height: 16.0),
              CustomInputField(
                controller: _goldenCoinsController,
                labelText: 'Golden coins',
                hintText: 'Golden coins',
                keyboardType: TextInputType.number,
                errorText: _goldenCoinsError,
              ),
              const SizedBox(height: 24.0),

              CustomDropdownField(
                value: _selectedOxfordDominoes,
                hintText: 'OXFORD DOMINOES & BOOKWORMS Quick Starter Part',
                items: _oxfordDominoesOptions,
                onChanged: (newValue) {
                  setState(() {
                    _selectedOxfordDominoes = newValue;
                    _oxfordDominoesError = null;
                  });
                },
                errorText: _oxfordDominoesError,
              ),
              const SizedBox(height: 16.0),
              CustomDropdownField(
                value: _selectedOxfordReadDiscover,
                hintText: 'OXFORD READ & DISCOVER 1-6 Level 1/R&D',
                items: _oxfordReadDiscoverOptions,
                onChanged: (newValue) {
                  setState(() {
                    _selectedOxfordReadDiscover = newValue;
                    _oxfordReadDiscoverError = null;
                  });
                },
                errorText: _oxfordReadDiscoverError,
              ),
              const SizedBox(height: 16.0),
              CustomDropdownField(
                value: _selectedNationalGeographic,
                hintText: 'NATIONAL GEOGRAPHIC A2 Part 1/N.G',
                items: _nationalGeographicOptions,
                onChanged: (newValue) {
                  setState(() {
                    _selectedNationalGeographic = newValue;
                    _nationalGeographicError = null;
                  });
                },
                errorText: _nationalGeographicError,
              ),
              const SizedBox(height: 16.0),
              CustomDropdownField(
                value: _selectedListeningSkill,
                hintText: 'LISTENING SKILL Begginers/L.S',
                items: _listeningSkillOptions,
                onChanged: (newValue) {
                  setState(() {
                    _selectedListeningSkill = newValue;
                    _listeningSkillError = null;
                  });
                },
                errorText: _listeningSkillError,
              ),
              const SizedBox(height: 24.0),

              ElevatedButton(
                onPressed: () {
                  if (_validateForm()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
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
    );
  }
}
