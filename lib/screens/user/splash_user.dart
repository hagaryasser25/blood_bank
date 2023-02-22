import 'package:blood_bank/screens/admin/admin_home.dart';
import 'package:blood_bank/screens/auth/admin_login.dart';
import 'package:blood_bank/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../auth/user_login.dart';


class SplashUser extends StatefulWidget {
  static const routeName = '/splashUser';
  const SplashUser({super.key});

  @override
  State<SplashUser> createState() => _SplashUserState();
}

class _SplashUserState extends State<SplashUser> {
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
              height: 50.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 10.w),
              child: Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/images/blood.jfif',
                    height: 120,
                    width: 120,
                  )),
            ),
            Center(
                child: Text('أهلا بك فى تطبيق التبرع بالدم',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600))),
            Padding(
              padding: EdgeInsets.only(right: 35.w, left: 35.w),
              child: Image.asset('assets/images/logo.jfif'),
            ),
            SizedBox(
              width: 180.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, UserLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(

                      side: BorderSide(
                          width: 3.0, color: Color.fromARGB(255, 225, 60, 48))),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    "تسجيل الدخول",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(
              width: 180.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, SignupPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 3.0, color: Color.fromARGB(255, 225, 60, 48))),
                  icon: const Icon(Icons.local_hospital),
                  label: const Text(
                    "انشاء حساب",
                    style: TextStyle(fontSize: 18),
                  )),
            ),

            Center(
                child: Padding(
                  padding:  EdgeInsets.only(
                    right: 35.w,
                    left: 35.w,
                    top: 20.h
                  ),
                  child: Text(
                      'يمكن لجميع الأشخاص التبرع بالدم فى حال تمتعهم بصحة جيدة.وهناك بعض المتطلبات الأساسة التى لا بد من الوفاء بها للتبرع بالدم ويرد أدناه بعض المبادآ التوجيهية الأساسية لأهلية التبرع بالدم',
                      style: TextStyle(color: Colors.grey),),
                ))
          ],
        )),
      ),
    );
  }
}