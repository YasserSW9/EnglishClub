// lib/features/prizes/ui/widgets/single_prize_tile.dart
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/features/student_prizes/data/models/prizes_response.dart';
import 'package:english_club/features/student_prizes/logic/cubit/prizes_cubit.dart';
import 'package:english_club/features/student_prizes/ui/widgets/prize_avatar.dart';
import 'package:english_club/features/student_prizes/ui/widgets/prize_details_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SinglePrizeTile extends StatelessWidget {
  final PrizeItem prizeItem;
  final int index;
  final TabController tabController;

  const SinglePrizeTile({
    super.key,
    required this.prizeItem,
    required this.index,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    final ValueKey itemKey = ValueKey(prizeItem.id ?? index);

    return ExpansionTile(
      key: itemKey,
      leading: PrizeAvatar(
        profilePictureUrl: prizeItem.giveItTo?.profilePicture,
      ),
      title: Text(
        prizeItem.giveItTo?.name ?? "N/A",
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (prizeItem.collected == 0) // Show checkbox only if not collected
            SizedBox(
              width: 24.w,
              height: 24.h,
              child: Checkbox(
                value: false, // Always false initially, as it triggers action
                onChanged: (bool? newValue) {
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.info,
                    animType: AnimType.rightSlide,
                    title: 'Collect Prize',
                    desc:
                        'Mark "${prizeItem.giveItTo?.name ?? "student"}" as collected?',
                    btnCancelText: "No",
                    btnOkText: "Yes",
                    btnOkOnPress: () {
                      if (prizeItem.studentId != null && prizeItem.id != null) {
                        context.read<PrizesCubit>().collectPrize(
                          studentId: prizeItem.studentId!,
                          prizeItemId: prizeItem.prizeId!,
                        );

                        tabController.animateTo(1); // Switch to collected tab
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Error: Student ID or Prize Item ID is missing.',
                            ),
                          ),
                        );
                      }
                    },
                    btnCancelOnPress: () {},
                  ).show();
                },
              ),
            ),
          const Icon(Icons.expand_more),
        ],
      ),
      backgroundColor: (prizeItem.collected == 1)
          ? const Color.fromARGB(255, 205, 207, 205)
          : const Color.fromARGB(255, 216, 212, 212),
      onExpansionChanged: (expanded) {
        // Handle expansion changes if needed
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: PrizeDetailsWidget(prizeItem: prizeItem),
        ),
      ],
    );
  }
}
