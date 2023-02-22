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

class AddBag extends StatefulWidget {
  static const routeName = '/addBag';
  const AddBag({super.key});

  @override
  State<AddBag> createState() => _AddBagState();
}

class _AddBagState extends State<AddBag> {
  var quantityController = TextEditingController();
  String dropdownValue = '+A';
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
                          String type = dropdownValue;
                          String? name = currentUser.name;

                          if (quantity== null) {
                            CherryToast.info(
                              title: Text('ادخل عدد الأكياس'),
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
                                .child('bloodBags').child('$name');

                            String? id = companyRef.push().key;

                            await companyRef.child(id!).set({
                              'id': id,
                              'quantity': quantity,
                              'hospitalUid': uid,
                              'type': type,
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
