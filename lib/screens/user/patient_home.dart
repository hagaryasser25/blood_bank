import 'package:blood_bank/screens/hospital/add_bag.dart';
import 'package:blood_bank/screens/user/bag_request.dart';
import 'package:blood_bank/screens/user/blood_types.dart';
import 'package:blood_bank/screens/user/user_donators.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../splash_screen.dart';

class PatientHome extends StatefulWidget {
  static const routeName = '/patientHome';
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(         
          body: Column(
            children: [
              SizedBox(
                height: 100.h,
              ),
              Image.asset('assets/images/home.jfif'),
              SizedBox(height: 20.h),
              Text('الخدمات المتاحة',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
              Padding(
                padding:  EdgeInsets.only(
                  top: 20.h
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                         Navigator.pushNamed(context, UserDonators.routeName);
                      },
                      child: card('#2196F3', 'قائمة المتبرعين')),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, BagRequest.routeName);
                        },
                        child: card('#2196F3', 'أطلب كيس دم')),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('تأكيد'),
                            content: Text('هل انت متأكد من تسجيل الخروج'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.signOut();
                                  Navigator.pushNamed(
                                      context, SplashScreen.routeName);
                                },
                                child: Text('نعم'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('لا'),
                              ),
                            ],
                          );
                        });
                  },
                  child: card('#ff3c30', 'تسجيل الخروج')),
            ],
          ),
        ),
      ),
    );
  }
}

Widget card(String color, String text) {
  return Container(
    child: Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.white,
        ),
        borderRadius: BorderRadius.circular(20.0), //<-- SEE HERE
      ),
      color: HexColor(color),
      child: SizedBox(
        width: 177.w,
        height: 100.h,
        child: Padding(
          padding: EdgeInsets.only(right: 10.w, left: 10.w),
          child: Row(
            children: [
              Icon(Icons.ac_unit, color: Colors.white),
              SizedBox(width: 20.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
