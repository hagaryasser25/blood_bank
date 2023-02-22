import 'dart:io';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndialog/ndialog.dart';

import 'admin_home.dart';

class AddHospital extends StatefulWidget {
  static const routeName = '/addHospital';
  const AddHospital({super.key});

  @override
  State<AddHospital> createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 60.h,
            ),
            child: Padding(
              padding: EdgeInsets.only(right: 10.w, left: 10.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 35.w, left: 35.w),
                      child: Image.asset('assets/images/logo.jfif'),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 225, 60, 48),
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'الأسم',
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 225, 60, 48),
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'البريد الالكترونى',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: passwordController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 225, 60, 48),
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'كلمة المرور',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints.tightFor(
                          width: double.infinity, height: 65.h),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Color.fromARGB(255, 225, 60, 48),
                        ),
                        onPressed: () async {
                          String name = nameController.text.trim();
                          String email = emailController.text.trim();
                          String password = passwordController.text.trim();

                          if (name.isEmpty ||
                              email.isEmpty ||
                              password.isEmpty) {
                            CherryToast.info(
                              title: Text('Please Fill all Fields'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          if (password.length < 6) {
                            // show error toast
                            CherryToast.info(
                              title: Text(
                                  'Weak Password, at least 6 characters are required'),
                              actionHandler: () {},
                            ).show(context);

                            return;
                          }

                          ProgressDialog progressDialog = ProgressDialog(
                              context,
                              title: Text('Signing Up'),
                              message: Text('Please Wait'));
                          progressDialog.show();

                          try {
                            FirebaseAuth auth = FirebaseAuth.instance;

                            UserCredential userCredential =
                                await auth.createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            User? user = userCredential.user;
                            user!.updateProfile(displayName: 'مستشفى');

                            if (userCredential.user != null) {
                              DatabaseReference hospitalRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('hospitals');
                              String? id = hospitalRef.push().key;

                              String uid = userCredential.user!.uid;
                              int dt = DateTime.now().millisecondsSinceEpoch;

                              await hospitalRef.child(id!).set({
                                'name': name,
                                'email': email,
                                'password': password,
                                'uid': uid,
                                'id': id,
                              });

                              DatabaseReference userRef = FirebaseDatabase
                                  .instance
                                  .reference()
                                  .child('users');

                              await userRef.child(uid).set({
                                'name': name,
                                'email': email,
                                'uid': uid,
                                'dt': dt,
                                'phoneNumber': '',
                                'role': 'مستشفى',
                              });

                               FirebaseAuth.instance.signOut();
                              Navigator.canPop(context)
                                  ? Navigator.pop(context)
                                  : null;
                            } else {
                              CherryToast.info(
                                title: Text('Failed'),
                                actionHandler: () {},
                              ).show(context);
                            }
                            progressDialog.dismiss();
                          } on FirebaseAuthException catch (e) {
                            progressDialog.dismiss();
                            if (e.code == 'email-already-in-use') {
                              CherryToast.info(
                                title: Text('Email is already exist'),
                                actionHandler: () {},
                              ).show(context);
                            } else if (e.code == 'weak-password') {
                              CherryToast.info(
                                title: Text('Password is weak'),
                                actionHandler: () {},
                              ).show(context);
                            }
                          } catch (e) {
                            progressDialog.dismiss();
                            CherryToast.info(
                              title: Text('Something went wrong'),
                              actionHandler: () {},
                            ).show(context);
                          }
                        },
                        child: Text('حفظ'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void showAlertDialog(BuildContext context) {
  Widget remindButton = TextButton(
    style: TextButton.styleFrom(
      primary: HexColor('#6bbcba'),
    ),
    child: Text("Ok"),
    onPressed: () {
      Navigator.pushNamed(context, AdminHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة المستشفى"),
    actions: [
      remindButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
