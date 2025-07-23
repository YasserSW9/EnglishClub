// lib/core/widgets/english_club_app_bar.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/core/helpers/extensions.dart'; // Ensure correct path
import 'package:flutter_bloc/flutter_bloc.dart'; // For BlocProvider.of

// Import the Cubit and RequestBody
import 'package:english_club/features/english_club/data/models/create_section_request_body.dart'; // Ensure correct path
import 'package:english_club/features/english_club/logic/create_section_cubit.dart'; // Ensure correct path

class EnglishClubAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EnglishClubAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          context.pop();
        },
      ),
      title: Text(
        'English club settings',
        style: TextStyle(color: Colors.white, fontSize: 18.sp),
      ),
      actions: [
        InkWell(
          onTap: () {
            AwesomeDialog(
              context: context,
              dialogType: DialogType.info,
              animType: AnimType.rightSlide,
              title: 'Add New Section',
              desc: 'Please enter the section name:',
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: context
                      .read<CreateSectionCubit>()
                      .sectionNameController,
                  decoration: const InputDecoration(
                    hintText: 'Section Name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              btnOkText: 'Add',
              btnCancelText: 'Cancel',
              btnOkOnPress: () {
                final createSectionCubit = context.read<CreateSectionCubit>();
                final sectionName = createSectionCubit
                    .sectionNameController
                    .text
                    .trim();
                if (sectionName.isNotEmpty) {
                  createSectionCubit.emitCreateSection();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Section name cannot be empty!'),
                    ),
                  );
                }
                createSectionCubit.sectionNameController.clear();
              },
              btnCancelOnPress: () {
                context
                    .read<CreateSectionCubit>()
                    .sectionNameController
                    .clear();
              },
            ).show();
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Icon(Icons.add_circle_outline, color: Colors.white),
                SizedBox(width: 5),
                Text('new section', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ),
        const SizedBox(width: 5),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
