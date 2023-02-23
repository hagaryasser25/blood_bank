import 'package:blood_bank/screens/models/user_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class DonatorsApp extends StatefulWidget {
  static const routeName = '/donatorsApp';
  const DonatorsApp({super.key});

  @override
  State<DonatorsApp> createState() => _DonatorsAppState();
}

class _DonatorsAppState extends State<DonatorsApp> {
  late DatabaseReference base;
  late FirebaseDatabase database;
  late FirebaseApp app;
  List<Users> usersList = [];
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
    base = database.reference().child("users");
    base.orderByChild("role").equalTo("متبرع").onChildAdded.listen((event) {
      print(event.snapshot.value);
      Users p = Users.fromJson(event.snapshot.value);
      usersList.add(p);
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
              title: Text('بيانات المتبرعين')),
          body: Container(
            width: double.infinity,
            height: 10000,
            child: StaggeredGridView.countBuilder(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 15.w,
                right: 15.w,
                bottom: 15.h,
              ),
              crossAxisCount: 6,
              itemCount: usersList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Column(children: [
                    SizedBox(height: 30.h),
                    Text(
                      '${usersList[index].name.toString()}',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Text(
                      '${usersList[index].email.toString()}',
                    ),
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
                        base.child(usersList[index].id.toString()).remove();
                      },
                      child: Icon(Icons.delete,
                          color: Color.fromARGB(255, 122, 122, 122)),
                    )
                  ]),
                );
              },
              staggeredTileBuilder: (int index) =>
                  new StaggeredTile.count(3, index.isEven ? 3 : 3),
              mainAxisSpacing: 1,
              crossAxisSpacing: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}
