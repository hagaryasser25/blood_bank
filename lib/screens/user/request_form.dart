import 'dart:io';
import 'package:blood_bank/screens/user/user_home.dart';
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

class RequestForm extends StatefulWidget {
  String typeId;
  String hospitalName;
  String oldNumber;
  String hospitalUid;
  String type;
  static const routeName = '/requestForm';
  RequestForm(
      {required this.hospitalName,
      required this.typeId,
      required this.oldNumber,
      required this.hospitalUid,
      required this.type});

  @override
  State<RequestForm> createState() => _RequestFormState();
}

class _RequestFormState extends State<RequestForm> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
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
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 65.h,
                      child: TextField(
                        controller: phoneNumberController,
                        decoration: InputDecoration(
                          fillColor: HexColor('#155564'),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 225, 60, 48),
                                width: 2.0),
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'رقم الهاتف',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
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
                          var name = nameController.text.trim();
                          var phoneNumber = phoneNumberController.text.trim();
                          int quantity = int.parse(quantityController.text);
                          int oldd = int.parse(widget.oldNumber);
                          num total = oldd - quantity;

                          if (name.isEmpty) {
                            CherryToast.info(
                              title: Text('ادخل الأسم'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }
                          if (phoneNumber.isEmpty) {
                            CherryToast.info(
                              title: Text('ادخل رقم الهاتف'),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          if (quantity == null) {
                            CherryToast.info(
                              title: Text('ادخل عدد الأكياس '),
                              actionHandler: () {},
                            ).show(context);
                            return;
                          }

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            String uid = user.uid;

                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('bagsRequests');

                            String? id = companyRef.push().key;

                            await companyRef.child(id!).set({
                              'id': id,
                              'name': name,
                              'phoneNumber': phoneNumber,
                              'hospitalName': widget.hospitalName,
                              'hospitalUid': widget.hospitalUid,
                              'quantity': quantity,
                              'type': widget.type,
                            });

                            DatabaseReference bloodRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('bloodBags')
                                .child('${widget.hospitalName}')
                                .child('${widget.typeId}');

                            await bloodRef.update({
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
      Navigator.pushNamed(context, UserHome.routeName);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("تم ارسال الطلب"),
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
