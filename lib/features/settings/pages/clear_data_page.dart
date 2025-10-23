import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ClearDataPage extends StatelessWidget {
  const ClearDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(20),
          height: 100.h,
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 2.h),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                offset: const Offset(2, 2),
                blurRadius: 0,
              ),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                "Do you want to delete \nnall the history?",
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 40.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(2, 2),
                          blurRadius: 0,
                        ),
                      ],
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                  ),
                  SizedBox(width: 50.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(2, 2),
                          blurRadius: 0,
                        ),
                      ],
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(color: Colors.white, fontSize: 40.sp),
                    ),
                  ),

                  SizedBox(width: 5.w),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
