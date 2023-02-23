import 'package:blood_bank/screens/admin/add_hospital.dart';
import 'package:blood_bank/screens/models/hospitals_model.dart';
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

class AdminHospitals extends StatefulWidget {
  static const routeName = '/adminHospitals';
  const AdminHospitals({super.key});

  @override
  State<AdminHospitals> createState() => _AdminHospitalsState();
}

class _AdminHospitalsState extends State<AdminHospitals> {
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
            title: Align(
                alignment: Alignment.topRight,
                child: TextButton.icon(
                  // Your icon here
                  label: Text(
                    'أضافة مستشفى',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  icon: Align(
                      child: Icon(
                    Icons.add,
                    color: Colors.white,
                  )), // Your text here
                  onPressed: () {
                    Navigator.pushNamed(context, AddHospital.routeName);
                  },
                )),
          ),
          body: Container(
            width: double.infinity,
            height: 10000.h,
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
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: [
                    SizedBox(height: 30.h),
                    Text(
                      '${hospitalsList[index].name.toString()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),

                    Text(
                      '${hospitalsList[index].email.toString()}',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text('${hospitalsList[index].password.toString()}'),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));
                        base.child(hospitalsList[index].id.toString()).remove();
                      },
                      child: Icon(Icons.delete,
                          color: Color.fromARGB(255, 122, 122, 122)),
                    )
                  ]),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 15.0,
              crossAxisSpacing: 5.0,
            ),
          ),
        ),
      ),
    );
  }
}
