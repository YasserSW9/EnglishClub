import 'package:english_club/features/manage_grades_and_classes/data/models/grades_response.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/edit_grade_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/edit_grade_state.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_state.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/ManageGradesAndClassesAppBar.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/grades_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/core/helpers/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_state.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/_AddGradeButton.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/_GradeAndSectionCard.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/_NoGradesFoundWidget.dart';

class ManageGradesAndClasses extends StatefulWidget {
  const ManageGradesAndClasses({super.key});

  @override
  _ManageGradesAndClassesState createState() => _ManageGradesAndClassesState();
}

class _ManageGradesAndClassesState extends State<ManageGradesAndClasses> {
  List<Data> _gradesFromApi = [];

  @override
  void initState() {
    super.initState();

    context.read<GradesCubit>().emitGetGrades();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F1FA),
      appBar: const ManageGradesAndClassesAppBar(),
      body: MultiBlocListener(
        listeners: [
          BlocListener<GradesCubit, GradesState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (data) {
                  if (data is GradesResponse) {
                    setState(() {
                      _gradesFromApi = data.data ?? [];
                    });
                  }
                },
                error: (error) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Error',
                    desc:
                        error ??
                        'An unknown error occurred while fetching grades.',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),

          BlocListener<CreateGradesCubit, CreateGradesState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.bottomSlide,
                    title: 'Adding Grade',
                    desc: 'Please wait...',
                    autoHide: const Duration(seconds: 5),
                    headerAnimationLoop: true,
                  ).show();
                },
                success: (data) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    title: 'Success!',
                    desc: 'Grade added successfully.',
                    btnOkOnPress: () {
                      context.read<GradesCubit>().emitGetGrades();
                    },
                  ).show();
                },
                error: (error) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Error',
                    desc:
                        error ??
                        'An unknown error occurred during grade creation.',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),

          BlocListener<EditGradeCubit, EditGradeState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.bottomSlide,
                    title: 'Updating Grade',
                    desc: 'Please wait...',
                    autoHide: const Duration(seconds: 5),
                    headerAnimationLoop: true,
                  ).show();
                },
                success: (data) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    title: 'Success!',
                    desc: 'Grade updated successfully.',
                    btnOkOnPress: () {
                      context.read<GradesCubit>().emitGetGrades();
                    },
                  ).show();
                },
                error: (error) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Error',
                    desc:
                        error ??
                        'An unknown error occurred during grade update.',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
        ],
        child: BlocBuilder<GradesCubit, GradesState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: Text('Loading grades...')),
              loading: () => const GradesShimmerLoading(),
              success: (data) {
                if (data is GradesResponse &&
                    (data.data?.isNotEmpty ?? false)) {
                  return ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      AddGradeButton(
                        onCreateGrade: () {
                          context
                              .read<CreateGradesCubit>()
                              .gradeNameController
                              .clear();
                          AwesomeDialog(
                            context: context,
                            dialogType: DialogType.question,
                            animType: AnimType.bottomSlide,
                            title: "Add New Grade",
                            body: Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextField(
                                controller: context
                                    .read<CreateGradesCubit>()
                                    .gradeNameController,
                                decoration: InputDecoration(
                                  labelText: 'Grade Name',
                                  hintText: 'e.g., Grade 10',
                                  border: const OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                ),
                              ),
                            ),
                            btnOkText: 'Add',
                            btnCancelText: 'Cancel',
                            btnOkOnPress: () {
                              final createCubit = context
                                  .read<CreateGradesCubit>();
                              if (createCubit.gradeNameController.text
                                  .trim()
                                  .isEmpty) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.warning,
                                  title: 'Input Required',
                                  desc: 'Grade name cannot be empty.',
                                  btnOkOnPress: () {},
                                ).show();
                                return;
                              }
                              createCubit.emitCreateGradeLoaded();
                            },
                            btnCancelOnPress: () {
                              context
                                  .read<CreateGradesCubit>()
                                  .gradeNameController
                                  .clear();
                            },
                          )..show();
                        },
                      ),
                      const SizedBox(height: 20),

                      for (
                        int gradeIndex = 0;
                        gradeIndex < _gradesFromApi.length;
                        gradeIndex++
                      )
                        GradeAndSectionCard(
                          grade: _gradesFromApi[gradeIndex],
                          onGradeDeleted: (gradeToDelete) {
                            setState(() {
                              _gradesFromApi.removeWhere(
                                (g) => g.id == gradeToDelete.id,
                              );
                            });
                          },
                          onSectionDeleted: (sectionToDelete, gradeId) {
                            setState(() {
                              final gradeToUpdate = _gradesFromApi.firstWhere(
                                (g) => g.id == gradeId,
                              );
                              gradeToUpdate.classes?.removeWhere(
                                (s) => s.id == sectionToDelete.id,
                              );
                            });
                          },

                          onGradeNameEdited: (gradeToEdit, newName) {
                            context.read<EditGradeCubit>().nameController.text =
                                newName;

                            context.read<EditGradeCubit>().emitEditGradeLoaded(
                              gradeId: gradeToEdit.id!,
                            );
                          },
                          onSectionNameEdited:
                              (sectionToEdit, newName, gradeId) {
                                setState(() {
                                  final gradeToUpdate = _gradesFromApi
                                      .firstWhere((g) => g.id == gradeId);
                                  final sectionToUpdate = gradeToUpdate.classes
                                      ?.firstWhere(
                                        (s) => s.id == sectionToEdit.id,
                                      );
                                  if (sectionToUpdate != null) {
                                    sectionToUpdate.name = newName;
                                  }
                                });
                              },
                        ),
                    ],
                  );
                } else {
                  return NoGradesFoundWidget(
                    onCreateGrade: () {
                      context
                          .read<CreateGradesCubit>()
                          .gradeNameController
                          .clear();
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.question,
                        animType: AnimType.bottomSlide,
                        title: "Add New Grade",
                        body: Padding(
                          padding: const EdgeInsets.all(16),
                          child: TextField(
                            controller: context
                                .read<CreateGradesCubit>()
                                .gradeNameController,
                            decoration: InputDecoration(
                              labelText: 'Grade Name',
                              hintText: 'e.g., Grade 10',
                              border: const OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.grey[100],
                            ),
                          ),
                        ),
                        btnOkText: 'Add',
                        btnCancelText: 'Cancel',
                        btnOkOnPress: () {
                          final createCubit = context.read<CreateGradesCubit>();
                          if (createCubit.gradeNameController.text
                              .trim()
                              .isEmpty) {
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.warning,
                              title: 'Input Required',
                              desc: 'Grade name cannot be empty.',
                              btnOkOnPress: () {},
                            ).show();
                            return;
                          }
                          createCubit.emitCreateGradeLoaded();
                        },
                        btnCancelOnPress: () {
                          context
                              .read<CreateGradesCubit>()
                              .gradeNameController
                              .clear();
                        },
                      )..show();
                    },
                  );
                }
              },
              error: (error) => Center(
                child: Text(
                  'Failed to load grades: ${error ?? 'Unknown error'}',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
