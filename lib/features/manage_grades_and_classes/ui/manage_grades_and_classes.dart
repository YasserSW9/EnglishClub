import 'package:english_club/features/manage_grades_and_classes/data/models/grades_response.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/grades_state.dart';
import 'package:english_club/features/manage_grades_and_classes/ui/widgets/grades_shimmer_loading.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/core/helpers/extensions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Import the new Cubit and its state for creating grades
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_cubit.dart';
import 'package:english_club/features/manage_grades_and_classes/logic/cubit/create_grades_state.dart';

class ManageGradesAndClasses extends StatefulWidget {
  const ManageGradesAndClasses({super.key});

  @override
  _ManageGradesAndClassesState createState() => _ManageGradesAndClassesState();
}

class _ManageGradesAndClassesState extends State<ManageGradesAndClasses> {
  // Keep this controller for editing existing grades/sections
  final TextEditingController _textController = TextEditingController();

  List<Data> _gradesFromApi = [];

  @override
  void initState() {
    super.initState();
    // Fetch existing grades when the widget initializes
    context.read<GradesCubit>().emitGetGrades();
  }

  @override
  void dispose() {
    _textController.dispose(); // Dispose the local controller
    // The controller for CreateGradesCubit is disposed within its own close method
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
      body: MultiBlocListener(
        // Use MultiBlocListener to listen to multiple Cubits
        listeners: [
          // Listener for fetching existing grades
          BlocListener<GradesCubit, GradesState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (data) {
                  if (data is GradesResponse) {
                    setState(() {
                      // ✅ تأكد أن data.data ليس null قبل التعيين
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
                    // ✅ تم التعديل هنا: استخدام ?? لتوفير رسالة افتراضية إذا كان 'error' null
                    desc:
                        error ??
                        'An unknown error occurred while fetching grades.',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
          // New Listener for CreateGradesCubit
          BlocListener<CreateGradesCubit, CreateGradesState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  // Show loading indicator
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.bottomSlide,
                    title: 'Adding Grade',
                    desc: 'Please wait...',
                    autoHide: const Duration(
                      seconds: 5,
                    ), // ✅ Added autoHide duration (or remove if you want manual dismiss)
                    headerAnimationLoop: true,
                  ).show();
                },
                success: (data) {
                  // Hide loading dialog if it's currently showing
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(
                      context,
                    ).pop(); // To dismiss the loading dialog
                  }
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.bottomSlide,
                    title: 'Success!',
                    desc: 'Grade added successfully.',
                    btnOkOnPress: () {
                      // ✅ بعد النجاح، أعد جلب الصفوف لتحديث واجهة المستخدم
                      // هذا هو الجزء الذي يتسبب في الخطأ إذا كانت البيانات المعاداة null
                      context.read<GradesCubit>().emitGetGrades();
                      // لا داعي لإغلاق الصفحة هنا، التحديث سيحدث في نفس الصفحة
                    },
                  ).show();
                },
                error: (error) {
                  // Hide loading dialog if it's currently showing
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(
                      context,
                    ).pop(); // To dismiss the loading dialog
                  }
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.bottomSlide,
                    title: 'Error',
                    // ✅ تم التعديل هنا: استخدام ?? لتوفير رسالة افتراضية إذا كان 'error' null
                    desc:
                        error ??
                        'An unknown error occurred during grade creation.',
                    btnOkOnPress: () {},
                  ).show();
                },
              );
            },
          ),
        ],
        child: BlocBuilder<GradesCubit, GradesState>(
          // BlocBuilder for GradesCubit to build UI
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
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Clear the cubit's controller before showing the dialog
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
                                  // Use the controller from CreateGradesCubit for adding a new grade
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
                                  return; // Stop if input is empty
                                }
                                // Call the cubit's method to initiate grade creation
                                createCubit.emitCreateGradeLoaded();
                                // No direct setState or controller clear here, as cubit will handle state changes
                              },
                              btnCancelOnPress: () {
                                // Clear the cubit's controller if dialog is cancelled
                                context
                                    .read<CreateGradesCubit>()
                                    .gradeNameController
                                    .clear();
                              },
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
                      for (
                        int gradeIndex = 0;
                        gradeIndex < _gradesFromApi.length;
                        gradeIndex++
                      )
                        Builder(
                          builder: (context) {
                            // ✅ حماية إضافية: تأكد أن grade ليس null
                            final Data? grade = _gradesFromApi[gradeIndex];
                            if (grade == null)
                              return const SizedBox.shrink(); // لا تعرض إذا كان null

                            // تأكد أن `classes` هي قائمة قابلة للـ null (List<Classes>?)
                            final List<Classes> sections = grade.classes ?? [];

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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            // Use the local _textController for editing existing grades
                                            _textController.text =
                                                grade.name ?? '';
                                            AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.info,
                                              animType: AnimType.scale,
                                              title: 'Edit Grade Name',
                                              body: Padding(
                                                padding: const EdgeInsets.all(
                                                  16,
                                                ),
                                                child: TextField(
                                                  controller:
                                                      _textController, // Using local controller for existing edits
                                                  decoration: InputDecoration(
                                                    labelText: 'Grade Name',
                                                    // ✅ تم التعديل هنا: استخدام ?? ''
                                                    hintText:
                                                        'New name for "${grade.name ?? ''}"',
                                                    border:
                                                        const OutlineInputBorder(),
                                                    filled: true,
                                                    fillColor: Colors.grey[100],
                                                  ),
                                                ),
                                              ),
                                              btnOkText: 'Save',
                                              btnCancelText: 'Cancel',
                                              btnOkOnPress: () {
                                                final String newName =
                                                    _textController.text.trim();
                                                if (newName.isEmpty) return;
                                                setState(() {
                                                  // تأكد أن `name` في نموذج `Data` قابل للـ null إذا كنت تعين له قيمة.
                                                  // إذا لم يكن، فسيحتاج إلى معالجة خاصة إذا كان newName فارغاً.
                                                  // لكن هنا newName لن يكون فارغاً بسبب التحقق.
                                                  _gradesFromApi[gradeIndex]
                                                          .name =
                                                      newName;
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
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          child: Text(
                                            grade.name ?? '',
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
                                              // ✅ تم التعديل هنا: استخدام ?? ''
                                              desc:
                                                  'Are you sure you want to delete "${grade.name ?? ''}"? This action cannot be undone.',
                                              btnOkText: 'Delete',
                                              btnCancelText: 'Cancel',
                                              btnOkOnPress: () {
                                                setState(() {
                                                  _gradesFromApi.removeAt(
                                                    gradeIndex,
                                                  );
                                                });
                                                AwesomeDialog(
                                                  context: context,
                                                  dialogType:
                                                      DialogType.success,
                                                  title: 'Deleted!',
                                                  // ✅ تم التعديل هنا: استخدام ?? ''
                                                  desc:
                                                      '"${grade.name ?? ''}" has been successfully removed.',
                                                  btnOkOnPress: () {},
                                                ).show();
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
                                    if (sections.isNotEmpty)
                                      for (
                                        int sectionIndex = 0;
                                        sectionIndex < sections.length;
                                        sectionIndex++
                                      )
                                        Dismissible(
                                          // ✅ تم التعديل هنا: استخدام ?? 0 لـ grade.id و sections[sectionIndex].id
                                          // إذا كانت هذه القيم يمكن أن تكون null وكان ValueKey يتوقع غير null
                                          key: ValueKey(
                                            '${grade.id ?? 0}_${sections[sectionIndex].id ?? sectionIndex}',
                                          ),
                                          direction:
                                              DismissDirection.horizontal,
                                          background: Container(
                                            color: Colors.red,
                                            alignment: Alignment.centerLeft,
                                            padding: const EdgeInsets.only(
                                              left: 20,
                                            ),
                                            child: const Icon(
                                              Icons.delete,
                                              color: Colors.white,
                                            ),
                                          ),
                                          secondaryBackground: Container(
                                            color: Colors.blue,
                                            alignment: Alignment.centerRight,
                                            padding: const EdgeInsets.only(
                                              right: 20,
                                            ),
                                            child: const Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          ),
                                          confirmDismiss: (direction) async {
                                            if (direction ==
                                                DismissDirection.startToEnd) {
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.error,
                                                title: 'Delete Section',
                                                // ✅ تم التعديل هنا: استخدام ?? ''
                                                desc:
                                                    'Are you sure you want to delete "${sections[sectionIndex].name ?? ''}"? This cannot be undone.',
                                                btnOkText: 'Delete',
                                                btnCancelText: 'Cancel',
                                                btnOkOnPress: () {
                                                  setState(() {
                                                    sections.removeAt(
                                                      sectionIndex,
                                                    );
                                                  });
                                                  AwesomeDialog(
                                                    context: context,
                                                    dialogType:
                                                        DialogType.success,
                                                    title: 'Deleted!',
                                                    // ✅ تم التعديل هنا: استخدام ?? ''
                                                    desc:
                                                        '"${sections[sectionIndex].name ?? ''}" has been removed.',
                                                    btnOkOnPress: () {},
                                                  )..show();
                                                },
                                              )..show();
                                              return false;
                                            } else if (direction ==
                                                DismissDirection.endToStart) {
                                              // Use the local _textController for editing sections
                                              _textController.text =
                                                  sections[sectionIndex].name ??
                                                  '';
                                              AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                animType: AnimType.scale,
                                                title: 'Edit Section Name',
                                                body: Padding(
                                                  padding: const EdgeInsets.all(
                                                    16,
                                                  ),
                                                  child: TextField(
                                                    controller: _textController,
                                                    decoration: InputDecoration(
                                                      labelText: 'Section Name',
                                                      // ✅ تم التعديل هنا: استخدام ?? ''
                                                      hintText:
                                                          'New name for "${sections[sectionIndex].name ?? ''}"',
                                                      border:
                                                          const OutlineInputBorder(),
                                                      filled: true,
                                                      fillColor:
                                                          Colors.grey[100],
                                                    ),
                                                  ),
                                                ),
                                                btnOkText: 'Save',
                                                btnCancelText: 'Cancel',
                                                btnOkOnPress: () {
                                                  final String newSectionName =
                                                      _textController.text
                                                          .trim();
                                                  if (newSectionName.isEmpty)
                                                    return;
                                                  setState(() {
                                                    sections[sectionIndex]
                                                            .name =
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
                                            margin: const EdgeInsets.only(
                                              top: 8,
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 12,
                                              vertical: 14,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey[100],
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.04),
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            child: Text(
                                              sections[sectionIndex].name ?? '',
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
                  );
                } else {
                  // Also show the "Add New Grade +" button when no grades are found
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: Text('No grades found. Click below to add one.'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Clear the cubit's controller before showing the dialog
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
                                )..show();
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
                    ],
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
