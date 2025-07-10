// lib/profile_page/profile_page.dart
import 'package:english_club/core/helpers/spacing.dart';
import 'package:english_club/core/themeing/color_manager.dart';
import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/add_admin_button.dart';
import 'package:english_club/features/admin_main_screen/ui/widgets/profile_page/admin_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final List<Map<String, String>> admins = [
    {"name": "admin1"},
    {"name": "admin2"},
    {"name": "admin3"},
  ];

  final TextEditingController _newAdminNameController = TextEditingController();

  @override
  void dispose() {
    _newAdminNameController.dispose();
    super.dispose();
  }

  void _addNewAdmin() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      title: 'Add new admin',
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            Text(
              'Add new admin',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
            verticalSpacing(15),
            TextFormField(
              controller: _newAdminNameController,
              decoration: InputDecoration(
                labelText: 'Admin Name',
                hintText: 'Enter admin name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                  borderSide: BorderSide(color: ColorManager.main, width: 1.5),
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
      ),
      btnCancelOnPress: () {
        _newAdminNameController.clear();
      },
      btnOkOnPress: () {
        final String newAdminName = _newAdminNameController.text.trim();
        if (newAdminName.isNotEmpty) {
          _newAdminNameController.clear();
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.scale,
            title: 'Admin Created',
            desc: 'Admin: $newAdminName\nPassword: pass1',
            btnOkText: 'OK',
            btnOkColor: Colors.green,
            btnOkOnPress: () {
              setState(() {
                admins.add({"name": newAdminName});
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$newAdminName has been added!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          ).show();
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

  void _deleteAdmin(int index, String adminName) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.rightSlide,
      title: 'Confirm Deletion',
      desc: 'Are you sure you want to delete $adminName?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        setState(() {
          admins.removeAt(index);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$adminName has been removed'),
            duration: const Duration(seconds: 2),
          ),
        );
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
          AddAdminButton(onTap: _addNewAdmin),
          verticalSpacing(20),
          Expanded(
            child: ListView.builder(
              itemCount: admins.length,
              itemBuilder: (context, i) {
                final String adminName = admins[i]['name']!;
                // Using the custom AdminListItem widget
                return AdminListItem(
                  adminName: adminName,
                  onDelete: () => _deleteAdmin(i, adminName),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
