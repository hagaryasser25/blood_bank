import 'package:blood_bank/screens/admin/admin_home.dart';
import 'package:blood_bank/screens/auth/admin_login.dart';
import 'package:blood_bank/screens/auth/hospital_login.dart';
import 'package:blood_bank/screens/user/splash_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'auth/signup_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              width: 150.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, SplashUser.routeName);
                  },
                  style: ElevatedButton.styleFrom(

                      side: BorderSide(
                          width: 3.0, color: Color.fromARGB(255, 225, 60, 48))),
                  icon: const Icon(Icons.person),
                  label: const Text(
                    "المستخدم",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(
              width: 150.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, HospitalLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 3.0, color: Color.fromARGB(255, 225, 60, 48))),
                  icon: const Icon(Icons.local_hospital),
                  label: const Text(
                    "المستشفى",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(
              width: 150.w,
              child: ElevatedButton.icon(
                  onPressed: () {
                     Navigator.pushNamed(context, AdminLogin.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      side: BorderSide(
                          width: 3.0, color: Color.fromARGB(255, 225, 60, 48))),
                  icon: const Icon(Icons.admin_panel_settings),
                  label: const Text(
                    "الأدمن",
                    style: TextStyle(fontSize: 18),
                  )),
            ),
            SizedBox(height: 15.h,),
            Center(
                child: Padding(
                  padding:  EdgeInsets.only(
                    right: 35.w,
                    left: 35.w,
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
