import 'package:blood_bank/screens/admin/add_hospital.dart';
import 'package:blood_bank/screens/hospital/add_bag.dart';
import 'package:blood_bank/screens/models/bags_model.dart';
import 'package:blood_bank/screens/models/hospitals_model.dart';
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
import 'edit_bag.dart';

class HospitalBags extends StatefulWidget {
  var name;
  static const routeName = '/hospitalBags';
  HospitalBags({required this.name});

  @override
  State<HospitalBags> createState() => _HospitalBagsState();
}

class _HospitalBagsState extends State<HospitalBags> {
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
              title: Align(
                  alignment: Alignment.topRight,
                  child: TextButton.icon(
                    // Your icon here
                    label: Text(
                      'أضافة فصيلة دم',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    icon: Align(
                        child: Icon(
                      Icons.add,
                      color: Colors.white,
                    )), // Your text here
                    onPressed: () {
                      Navigator.pushNamed(context, AddBag.routeName);
                    },
                  )),
            ),
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
                                  top: 18, right: 15, left: 15, bottom: 10),
                              child: Column(children: [
                                Center(
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
                                      SizedBox(
                                        width: 155.w,
                                        child: ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return EditBag(
                                                  name: widget.name,
                                                  id: '${bagsList[index].id.toString()}',
                                                  old: '${bagsList[index].quantity.toString()}',
                                                );
                                              }));
                                            },
                                            style: ElevatedButton.styleFrom(
                                                side: BorderSide(
                                                    width: 3.0,
                                                    color: Color.fromARGB(
                                                        255, 225, 60, 48))),
                                            icon: const Icon(Icons.add),
                                            label: const Text(
                                              "أضافة أكياس",
                                              style: TextStyle(fontSize: 18),
                                            )),
                                      ),
                                    ],
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
            )
            ),
      ),
    );
  }
}
