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

import '../models/usersh_model.dart';
import 'hospital_home.dart';

class EditBag extends StatefulWidget {
  var name;
  String old;
  String id;

  static const routeName = '/editBag';
  EditBag({required this.name, required this.old, required this.id});

  @override
  State<EditBag> createState() => _EditBagState();
}

class _EditBagState extends State<EditBag> {
  var quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Padding(
            padding: EdgeInsets.only(
              top: 120.h,
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
                        controller: quantityController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 225, 60, 48),
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'عدد الأكياس',
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
                          int quantity = int.parse(quantityController.text);
                          int oldd = int.parse(widget.old);
                          num total = quantity + oldd;

                          if (quantity == null) {
                            CherryToast.info(
                              title: Text('ادخل عدد الأكياس'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            String uid = user.uid;
                            int date = DateTime.now().millisecondsSinceEpoch;
                            print(total);

                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('bloodBags')
                                .child('${widget.name}')
                                .child('${widget.id}');

                            await companyRef.update({
                              'quantity': total,
                            });
                          }

                          showAlertDialog(context);
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
      Navigator.pushNamed(context, HospitalHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم أضافة أكياس الدم"),
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
