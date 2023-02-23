import 'package:blood_bank/screens/admin/admin_hospitals.dart';
import 'package:blood_bank/screens/admin/users_app.dart';
import 'package:blood_bank/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'donators_app.dart';

class AdminHome extends StatefulWidget {
  static const routeName = '/adminHome';
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          appBar: AppBar(
              backgroundColor: Color.fromARGB(255, 225, 60, 48),
              title: Center(child: Text('الصفحة الرئيسية'))),
          body: Column(
            children: [
              SizedBox(
                height: 70.h,
              ),
              Image.asset('assets/images/home.jfif'),
              SizedBox(height: 20.h),
              Text('الخدمات المتاحة',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.w500)),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AdminHospitals.routeName);
                      },
                      child: card('#ff3c30', 'أضافة مستشفى')),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, UsersApp.routeName);
                    },
                    child: card('#2196F3', 'بيانات المرضى')),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, DonatorsApp.routeName);
                    },
                    child: card('#2196F3', 'بيانات المتبرعين')),
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
              SizedBox(width: 10.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
