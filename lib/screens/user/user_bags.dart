import 'package:blood_bank/screens/admin/add_hospital.dart';
import 'package:blood_bank/screens/models/bags_model.dart';
import 'package:blood_bank/screens/models/hospitals_model.dart';
import 'package:blood_bank/screens/user/request_form.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/usersh_model.dart';

class UserBags extends StatefulWidget {
  var name;
  static const routeName = '/userBags';
  UserBags({required this.name});

  @override
  State<UserBags> createState() => _UserBagsState();
}

class _UserBagsState extends State<UserBags> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Bags> bagsList = [];
  List<String> keyslist = [];

  void didChangeDependencies() {
    fetchBags();
    super.didChangeDependencies();
  }

  @override
  void fetchBags() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bloodBags").child('${widget.name}');
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Bags p = Bags.fromJson(event.snapshot.value);
      bagsList.add(p);
      keyslist.add(event.snapshot.key.toString());
      setState(() {});
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
                title: Text('فصائل الدم')),
            body: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                itemCount: bagsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      Container(
                        height: 120.h,
                        child: Card(
                          color: HexColor('#ea9999'),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                   right: 15, left: 15, bottom: 10),
                              child: Column(children: [
                                Center(
                                  child: Padding(
                                    padding:  EdgeInsets.only(
                                      top: 30.h
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${bagsList[index].type.toString()}',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        Text(
                                          '${bagsList[index].quantity.toString()} كيس',
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(
                                          width: 40.w,
                                        ),
                                        ConstrainedBox(
                                          constraints: BoxConstraints.tightFor(
                                              width: 150.w, height: 40.h),
                                          child: ElevatedButton(
                                            child: Text('أطلب اكياس دم'),
                                            onPressed: () async {
                                              
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return RequestForm(
                                                  hospitalName: widget.name,
                                                  hospitalUid: '${bagsList[index].hospitalUid.toString()}',
                                                  oldNumber: '${bagsList[index].quantity.toString()}',
                                                  typeId: '${bagsList[index].id.toString()}',
                                                  type: '${bagsList[index].type.toString()}',
                                                  
                                                );
                                              }));
                                              
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      )
                    ],
                  );
                },
              ),
            )),
      ),
    );
  }
}
