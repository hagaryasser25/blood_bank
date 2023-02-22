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

class DonationForm extends StatefulWidget {
  String hospitalName;
  String hospitalUid;
  static const routeName = '/donationForm';
  DonationForm({required this.hospitalName, required this.hospitalUid});

  @override
  State<DonationForm> createState() => _DonationFormState();
}

class _DonationFormState extends State<DonationForm> {
  var nameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  String dropdownValue = '+A';
  String dropdownValue2 = 'من المنزل';

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
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),

                        // Step 3.
                        value: dropdownValue,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 225, 60, 48)),
                        ),

                        // Step 4.
                        items: [
                          '+A',
                          '-A',
                          '+B',
                          '-B',
                          '+AB',
                          '-AB',
                          '+O',
                          '-O'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 118, 118)),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                        },
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red, width: 2.0),
                        ),
                      ),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),

                        // Step 3.
                        value: dropdownValue2,
                        icon: Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.arrow_drop_down,
                              color: Color.fromARGB(255, 225, 60, 48)),
                        ),

                        // Step 4.
                        items: ['من المنزل', 'الذهاب الى المستشفى']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5,
                              ),
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 119, 118, 118)),
                              ),
                            ),
                          );
                        }).toList(),
                        // Step 5.
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue2 = newValue!;
                          });
                        },
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
                          var type = dropdownValue;
                          var way = dropdownValue2;

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

                          User? user = FirebaseAuth.instance.currentUser;

                          if (user != null) {
                            String uid = user.uid;

                            DatabaseReference companyRef = FirebaseDatabase
                                .instance
                                .reference()
                                .child('bloodDonation');

                            String? id = companyRef.push().key;

                            await companyRef.child(id!).set({
                              'id': id,
                              'name': name,
                              'phoneNumber': phoneNumber,
                              'type': type,
                              'way': way,
                              'hospitalName': widget.hospitalName,
                              'hospitalUid': widget.hospitalUid,
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
