// lib/profile_page/profile_page.dart
import 'package:english_club/core/helpers/spacing.dart';
import 'package:english_club/core/themeing/color_manager.dart';
import 'package:english_club/features/admin_main_screen/data/models/admin_response.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/admin_state.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/delete_admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/delete_admin_state.dart';

// Import the new cubit and state for creating an admin (corrected path)
import 'package:english_club/features/admin_main_screen/logic/cubit/create_admin_cubit.dart';
import 'package:english_club/features/admin_main_screen/logic/cubit/create_admin_state.dart';

import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/add_admin_button.dart';
import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/admin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/shimmer_admin_list_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // We will now use the TextEditingController from CreateAdminCubit
  // final TextEditingController _newAdminNameController = TextEditingController();

  // A nullable BuildContext to store the dialog's context
  BuildContext? _dialogContext;

  @override
  void initState() {
    super.initState();
    // Fetch admins when the page initializes
    context.read<AdminCubit>().emitGetAdminData();
  }

  @override
  void dispose() {
    // The controller is now managed by CreateAdminCubit, so we don't dispose it here.
    // _newAdminNameController.dispose();
    super.dispose();
  }

  void _addNewAdmin() {
    final createAdminCubit = context.read<CreateAdminCubit>();
    AwesomeDialog(
      context: context, // This is the context of ProfilePage
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Add new admin',
      body: Builder(
        // Use a Builder to get a context specific to the dialog's content
        builder: (BuildContext innerContext) {
          _dialogContext = innerContext; // Capture the dialog's context
          return Padding(
            padding: EdgeInsets.all(16.0.w),
            child: Column(
              children: [
                Text(
                  'Add new admin',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpacing(15),
                TextFormField(
                  controller:
                      createAdminCubit.nameController, // Use cubit's controller
                  decoration: InputDecoration(
                    labelText: 'Admin Name',
                    hintText: 'Enter admin name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: ColorManager.main,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
                verticalSpacing(20),
              ],
            ),
          );
        },
      ),
      btnCancelOnPress: () {
        createAdminCubit.nameController.clear(); // Clear cubit's controller
        // Dismiss the dialog using its specific context
        if (_dialogContext != null && Navigator.of(_dialogContext!).canPop()) {
          Navigator.of(_dialogContext!).pop();
        }
      },
      btnOkOnPress: () {
        final String newAdminName = createAdminCubit.nameController.text.trim();
        if (newAdminName.isNotEmpty) {
          // Trigger the create admin operation using the cubit
          createAdminCubit.emitCreateAdminLoaded();
          // DO NOT POP THE DIALOG HERE. It will be popped in the BlocListener.
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Admin name cannot be empty!'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      btnOkText: 'Create',
      btnOkColor: ColorManager.main,
    ).show();
  }

  void _confirmDeleteAdmin(String adminId, String adminName) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'Confirm Deletion',
      desc: 'Are you sure you want to delete $adminName?',
      btnCancelOnPress: () {}, // Do nothing on cancel
      btnOkOnPress: () {
        // Trigger the delete operation using DeleteAdminCubit
        context.read<DeleteAdminCubit>().emitDeleteAdminLoaded(adminId);
      },
      btnOkText: 'Delete',
      btnCancelText: 'Cancel',
      btnOkColor: Colors.red,
      btnCancelColor: Colors.blue,
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accounts", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Column(
        children: [
          verticalSpacing(20),
          // Wrap AddAdminButton with BlocListener for CreateAdminCubit
          BlocListener<CreateAdminCubit, CreateAdminState>(
            listener: (context, state) {
              state.whenOrNull(
                loading: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Creating admin...')),
                  );
                },
                success: (createAdminResponse) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  // Extract username and password
                  final String? username =
                      createAdminResponse.data?.account?.username;
                  final String? password =
                      createAdminResponse.data?.account?.password;

                  // Show AwesomeDialog with username and password
                  AwesomeDialog(
                    context:
                        context, // Use the main context for this new dialog
                    dialogType: DialogType.success,
                    animType: AnimType.scale,
                    title: 'Admin Created Successfully!',
                    desc:
                        'Username: ${username ?? 'N/A'}\nPassword: ${password ?? 'N/A'}',
                    btnOkText: 'OK',
                    btnOkColor: Colors.green,
                    btnOkOnPress: () {
                      // No action needed here, just dismiss
                    },
                  ).show();

                  // Refresh the admin list after successful creation
                  context.read<AdminCubit>().emitGetAdminData();
                  // Clear the text field after successful creation
                  context.read<CreateAdminCubit>().nameController.clear();
                  // Dismiss the initial dialog after successful creation using its specific context
                  if (_dialogContext != null &&
                      Navigator.of(_dialogContext!).canPop()) {
                    Navigator.of(_dialogContext!).pop();
                  }
                },
                error: (error) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to create admin: $error'),
                      backgroundColor: Colors.red,
                    ),
                  );
                  // Dismiss the dialog even on error using its specific context
                  if (_dialogContext != null &&
                      Navigator.of(_dialogContext!).canPop()) {
                    Navigator.of(_dialogContext!).pop();
                  }
                },
              );
            },
            child: AddAdminButton(onTap: _addNewAdmin),
          ),
          verticalSpacing(20),
          Expanded(
            child: BlocConsumer<AdminCubit, AdminState>(
              listener: (context, state) {
                // Listener for AdminCubit's errors
                state.whenOrNull(
                  error: (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(error),
                        backgroundColor: Colors.red,
                      ),
                    );
                  },
                );
              },
              builder: (context, state) {
                return state.when(
                  initial: () => const SizedBox.shrink(),
                  loading: () {
                    return ListView.builder(
                      itemCount: 5,
                      itemBuilder: (context, index) =>
                          const ShimmerAdminListItem(),
                    );
                  },
                  success: (adminsData) {
                    final List<AdminResponse> admins = adminsData;
                    if (admins.isEmpty) {
                      return const Center(child: Text('No admins found.'));
                    }
                    // ✅ BlocListener for DeleteAdminCubit is placed here,
                    // as it only needs to react to delete states without rebuilding the whole list.
                    return BlocListener<DeleteAdminCubit, DeleteAdminState>(
                      listener: (context, deleteState) {
                        deleteState.whenOrNull(
                          loading: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Deleting admin...'),
                              ),
                            );
                          },
                          success: (deleteResponse) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  deleteResponse.message ??
                                      'Admin deleted successfully!',
                                ),
                                backgroundColor: Colors.green,
                              ),
                            );

                            context.read<AdminCubit>().emitGetAdminData();
                          },
                          error: (error) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Failed to delete admin: $error'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                        );
                      },
                      child: ListView.builder(
                        itemCount: admins.length,
                        itemBuilder: (context, i) {
                          final String adminName = admins[i].name ?? 'N/A';
                          final String adminId =
                              admins[i].id.toString() ??
                              ''; // Assuming sId is the admin ID
                          return AdminListItem(
                            adminName: adminName,
                            // Pass both ID and Name to the confirmation dialog
                            onDelete: () =>
                                _confirmDeleteAdmin(adminId, adminName),
                          );
                        },
                      ),
                    );
                  },
                  error: (error) =>
                      Center(child: Text('Failed to load admins: $error')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
