import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:english_club/core/helpers/extensions.dart';
import 'package:english_club/core/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddStudents extends StatelessWidget {
  const AddStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF673AB7),
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white24,
              child: Icon(Icons.person, color: Colors.white),
            ),
            SizedBox(width: 15.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admin',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'admin',
                  style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.grey[50]),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Add Students Account",
                style: TextStyle(fontSize: 20.sp, color: Colors.black87),
              ),
              SizedBox(height: 30.h),

              InkWell(
                onTap: () {
                  print("excel");
                  AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    title: 'Are you Sure',
                    desc:
                        'All Students that you will upload via Excel wiil be  uploaded without any achievements.',
                    descTextStyle: TextStyle(fontSize: 14.sp),
                    btnOkText: 'Okay',
                    btnOkColor: Colors.indigoAccent,
                    btnCancelColor: Colors.grey,
                    btnCancelText: 'Cancel',
                    btnOkOnPress: () {
                      context.pushNamed(Routes.addStudentsByExcel);
                    },
                    btnCancelOnPress: () {
                      return;
                    },
                  )..show();
                },
                borderRadius: BorderRadius.circular(15.r),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Container(
                    width: 300.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.upload_file,
                          color: Colors.grey,
                          size: 30.sp,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Text(
                            "Add Students By Excel",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              InkWell(
                onTap: () {
                  print("Manual");
                  context.pushNamed(Routes.addStudentsManually);
                },
                borderRadius: BorderRadius.circular(15.r),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Container(
                    width: 300.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_add_rounded,
                          color: Colors.grey,
                          size: 30.sp,
                        ),
                        SizedBox(width: 25.w),
                        Expanded(
                          child: Text(
                            "Add Students Manually",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50.h),
              InkWell(
                onTap: () {
                  print("Manage");
                  context.pushNamed(Routes.ManageGradesAndClassess);
                },
                borderRadius: BorderRadius.circular(15.r),
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 25.w),
                  elevation: 8.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Container(
                    width: 300.w,
                    padding: EdgeInsets.symmetric(
                      vertical: 20.h,
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.settings_applications,
                          color: Colors.grey,
                          size: 30.sp,
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Text(
                            "Manage Grades and Classes",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
