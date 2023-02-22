import 'package:blood_bank/screens/hospital/add_bag.dart';
import 'package:blood_bank/screens/hospital/hospital_bags.dart';
import 'package:blood_bank/screens/hospital/hospital_donators.dart';
import 'package:blood_bank/screens/hospital/hospital_requests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../models/usersh_model.dart';
import '../splash_screen.dart';

class HospitalHome extends StatefulWidget {
  static const routeName = '/hospitalHome';
  const HospitalHome({super.key});

  @override
  State<HospitalHome> createState() => _HospitalHomeState();
}

class _HospitalHomeState extends State<HospitalHome> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  late UsersH currentUser;

  void didChangeDependencies() {
    getUserData();
    super.didChangeDependencies();
  }

  void initState() {
    getUserData();
    super.initState();
  }

  getUserData() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database
        .reference()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid);

    final snapshot = await base.get();
    setState(() {
      currentUser = UsersH.fromSnapshot(snapshot);
      print(currentUser.name);
    });
  }

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
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return HospitalBags(
                              name: currentUser.name,
                            );
                          }));
                        },
                        child: card('#ff3c30', 'أضافة اكياس دم')),
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, HospitalRequests.routeName);
                        },
                        child: card('#2196F3', 'طلبات شراء \nأكياس دم')),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, HospitalDonators.routeName);
                      },
                      child: card('#2196F3', 'طلبات التبرع')),
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
              SizedBox(width: 20.w),
              Text(text, style: TextStyle(fontSize: 17, color: Colors.white)),
            ],
          ),
        ),
      ),
    ),
  );
}
