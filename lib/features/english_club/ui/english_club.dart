import 'package:english_club/features/english_club/logic/create_section_cubit.dart';
import 'package:english_club/features/english_club/logic/create_section_state.dart';
import 'package:english_club/features/english_club/ui/widgets/english_club_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class Englishclub extends StatefulWidget {
  const Englishclub({super.key});

  @override
  State<Englishclub> createState() => _EnglishclubState();
}

class _EnglishclubState extends State<Englishclub> {
  final List<Map<String, dynamic>> sectionsData = const [
    {
      'title': 'Quick Starter Part 1',
      'images': ['image1.png', 'image2.png', 'image3.png', 'image4.png'],
    },
    {
      'title': 'Quick Starter Part 2',
      'images': ['image5.png', 'image6.png', 'image7.png', 'image8.png'],
    },
    {
      'title': 'Starter Part 1',
      'images': ['image9.png', 'image10.png', 'image11.png', 'image12.png'],
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const EnglishClubAppBar(),
      body: BlocListener<CreateSectionCubit, CreateSectionState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Creating section...')),
              );
            },
            success: (data) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                animType: AnimType.rightSlide,
                title: 'Success!',
                desc: 'Section "${data.data!.name}" created successfully.',
                btnOkOnPress: () {},
              ).show();
            },
            error: (error) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.rightSlide,
                title: 'Error!',
                desc: 'Failed to create section: $error',
                btnOkOnPress: () {},
              ).show();
            },
          );
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    const Text('sections'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: 'OXFORD DOMINOES & BOOKWORMS',
                            isExpanded: true,
                            icon: const Icon(Icons.arrow_drop_down),
                            items:
                                const <String>[
                                  'OXFORD DOMINOES & BOOKWORMS',
                                  'OXFORD READ &DISCOVER 1-6',
                                  'NATIONAL GEOGRAPHIC',
                                  'LISTENING SKILL',
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                            onChanged: (String? newValue) {},
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              ...sectionsData.map((section) {
                return Column(
                  children: [
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          section['title'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ExpansionTile(
                        title: const Center(
                          child: Text(
                            'D&B',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_down),
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8.0,
                                    mainAxisSpacing: 8.0,
                                    childAspectRatio: 0.7,
                                  ),
                              itemCount: section['images'].length,
                              itemBuilder:
                                  (BuildContext context, int imageIndex) {
                                    return Image.asset(
                                      'assets/${section['images'][imageIndex]}',
                                      fit: BoxFit.cover,
                                    );
                                  },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
