import 'package:blood_bank/screens/user/donation_form.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../models/hospitals_model.dart';

class DonationPage extends StatefulWidget {
  static const routeName = '/donationPage';
  const DonationPage({super.key});

  @override
  State<DonationPage> createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('assets/images/hospital.jfif', height: 250.h),
                Container(
                  height: 10000.h,
                  width: double.infinity,
                  child: StaggeredGridView.countBuilder(
                    padding: EdgeInsets.only(
                      top: 20.h,
                      left: 15.w,
                      right: 15.w,
                      bottom: 15.h,
                    ),
                    crossAxisCount: 6,
                    itemCount: hospitalsList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DonationForm(
                              hospitalName:
                                  '${hospitalsList[index].name.toString()}',
                              hospitalUid:
                                  '${hospitalsList[index].uid.toString()}',
                            );
                          }));
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(children: [
                            Image.asset('assets/images/hospital.jpg',height: 130.h,width: 130.h),
                            Text(
                              '${hospitalsList[index].name.toString()}',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ]),
                        ),
                      );
                    },
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.count(3, index.isEven ? 3 : 3),
                    mainAxisSpacing: 1.0,
                    crossAxisSpacing: 5.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
