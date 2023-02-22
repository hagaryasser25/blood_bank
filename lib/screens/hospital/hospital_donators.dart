import 'package:blood_bank/screens/models/donators_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HospitalDonators extends StatefulWidget {
  static const routeName = '/hospitalDonators';
  const HospitalDonators({super.key});

  @override
  State<HospitalDonators> createState() => _HospitalDonatorsState();
}

class _HospitalDonatorsState extends State<HospitalDonators> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Donators> donatorsList = [];
  List<String> keyslist = [];

  void didChangeDependencies() {
    fetchDonators();
    super.didChangeDependencies();
  }

  @override
  void fetchDonators() async {
    app = await Firebase.initializeApp();
    database = FirebaseDatabase(app: app);
    base = database.reference().child("bloodDonation");
    base.onChildAdded.listen((event) {
      print(event.snapshot.value);
      Donators p = Donators.fromJson(event.snapshot.value);
      donatorsList.add(p);
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
                title: Text('قائمة المتبرعين')),
            body: Padding(
              padding: EdgeInsets.only(
                top: 15.h,
                right: 10.w,
                left: 10.w,
              ),
              child: ListView.builder(
                itemCount: donatorsList.length,
                itemBuilder: (BuildContext context, int index) {
                  if (FirebaseAuth.instance.currentUser!.uid ==
                      donatorsList[index].hospitalUid) {
                    return Column(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 15, left: 15, bottom: 10),
                              child: Row(children: [
                                Container(
                                  width: 200.w,
                                  child: Column(
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'المتبرع : ${donatorsList[index].name.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'فصيلة الدم : ${donatorsList[index].type.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'الهاتف : ${donatorsList[index].phoneNumber.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                          Align(
                                          alignment: Alignment.topRight,
                                          child: Text(
                                            'طريقة التبرع : ${donatorsList[index].way.toString()}',
                                            style: TextStyle(fontSize: 17),
                                          )),
                                    ],
                                  ),
                                ),
                                Image.asset(
                                  'assets/images/blood2.jfif',
                                  height: 100.h,
                                )
                              ]),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        )
                      ],
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            )),
      ),
    );
  }
}
