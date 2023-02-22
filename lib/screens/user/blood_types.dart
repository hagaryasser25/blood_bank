import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/hospitals_model.dart';

class BloodTypes extends StatefulWidget {
  static const routeName = '/bloodTypes';
  const BloodTypes({super.key});

  @override
  State<BloodTypes> createState() => _BloodTypesState();
}

class _BloodTypesState extends State<BloodTypes> {
  var bloodTypes = ['+A', '-A', '+B', '-B', '+AB', '-AB', '+O', '-O'];

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
                itemCount: bloodTypes.length,
                itemBuilder: (BuildContext context, int index) {
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
                                    Text(
                                      '${bloodTypes[index]}',
                                      style: TextStyle(fontSize: 17),
                                    ),
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
                },
              ),
            )
            ),
      ),
    );
  }
}
