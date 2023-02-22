import 'package:blood_bank/screens/user/user_bags.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/hospitals_model.dart';

class BagRequest extends StatefulWidget {
  static const routeName = '/bagRequest';
  const BagRequest({super.key});

  @override
  State<BagRequest> createState() => _BagRequestState();
}

class _BagRequestState extends State<BagRequest> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Hospitals> hospitalsList = [];
  List<String> keyslist = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchHospitals();
  }

  @override
  void fetchHospitals() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("hospitals");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Hospitals p = Hospitals.fromJson(event.snapshot.value);
      hospitalsList.add(p);
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
              title: Text('قائمة المستشفيات')),
          body: Padding(
            padding: EdgeInsets.only(
              top: 15.h,
              right: 10.w,
              left: 10.w,
            ),
            child: ListView.builder(
              itemCount: hospitalsList.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Card(
                      color: Color.fromARGB(255, 226, 89, 79),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, right: 15, left: 15, bottom: 10),
                          child: Container(
                            width: 200.w,
                            child: Column(
                              children: [
                                Text(
                                  'اسم المستشفى : ${hospitalsList[index].name.toString()}',
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                ConstrainedBox(
                                  constraints: BoxConstraints.tightFor(
                                      width: 150.w, height: 40.h),
                                  child: ElevatedButton(
                                    child: Text('فصائل الدم المتاحة'),
                                    onPressed: () async {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return UserBags(
                                          name:
                                              '${hospitalsList[index].name.toString()}',
                                        );
                                      }));
                                    },
                                  ),
                                ),
                              ],
                            ),
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
          ),
        ),
      ),
    );
  }
}
