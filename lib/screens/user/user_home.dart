import 'package:blood_bank/screens/hospital/add_bag.dart';
import 'package:blood_bank/screens/models/usersh_model.dart';
import 'package:blood_bank/screens/user/donator_home.dart';
import 'package:blood_bank/screens/user/patient_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../splash_screen.dart';

class UserHome extends StatefulWidget {
  static const routeName = '/userHome';
  const UserHome({super.key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
            drawer: Drawer(
              child: FutureBuilder(
                future: getUserData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (currentUser == null) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      // Important: Remove any padding from the ListView.
                      padding: EdgeInsets.zero,
                      children: [
                        DrawerHeader(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 225, 60, 48),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.amber.shade500,
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage('assets/images/blood2.jfif',),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text("معلومات المستخدم",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white)),
                            ],
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.person,
                          ),
                          title: const Text('اسم المستخدم'),
                          subtitle: Text('${currentUser.name}'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.email,
                          ),
                          title: const Text('البريد الالكترونى'),
                          subtitle: Text('${currentUser.email}'),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.phone,
                          ),
                          title: const Text('رقم الهاتف'),
                          subtitle: Text('${currentUser.phoneNumber}'),
                        ),
                        Divider(
                          thickness: 0.8,
                          color: Colors.grey,
                        ),
                        Material(
                            color: Colors.transparent,
                            child: InkWell(
                                splashColor: Theme.of(context).splashColor,
                                child: ListTile(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Text('تأكيد'),
                                            content: Text(
                                                'هل انت متأكد من تسجيل الخروج'),
                                            actions: [
                                              TextButton(
                                                onPressed: () {
                                                  FirebaseAuth.instance
                                                      .signOut();
                                                  Navigator.pushNamed(context,
                                                      SplashScreen.routeName);
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
                                  title: Text('تسجيل الخروج'),
                                  leading: Icon(Icons.exit_to_app_rounded),
                                )))
                      ],
                    );
                  }
                },
              ),
            ),
            body: FirebaseAuth.instance.currentUser!.displayName == 'مريض'
                ? PatientHome()
                : DonatorHome()),
      ),
    );
  }
}
