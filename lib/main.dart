import 'package:blood_bank/screens/admin/add_hospital.dart';
import 'package:blood_bank/screens/admin/admin_home.dart';
import 'package:blood_bank/screens/admin/admin_hospitals.dart';
import 'package:blood_bank/screens/admin/users_app.dart';
import 'package:blood_bank/screens/auth/admin_login.dart';
import 'package:blood_bank/screens/auth/hospital_login.dart';
import 'package:blood_bank/screens/auth/signup_screen.dart';
import 'package:blood_bank/screens/auth/user_login.dart';
import 'package:blood_bank/screens/hospital/add_bag.dart';
import 'package:blood_bank/screens/hospital/hospital_bags.dart';
import 'package:blood_bank/screens/hospital/hospital_donators.dart';
import 'package:blood_bank/screens/hospital/hospital_home.dart';
import 'package:blood_bank/screens/hospital/hospital_requests.dart';
import 'package:blood_bank/screens/splash_screen.dart';
import 'package:blood_bank/screens/user/bag_request.dart';
import 'package:blood_bank/screens/user/blood_types.dart';
import 'package:blood_bank/screens/user/user_bags.dart';
import 'package:blood_bank/screens/user/user_donators.dart';
import 'package:blood_bank/screens/user/donation_page.dart';
import 'package:blood_bank/screens/user/splash_user.dart';
import 'package:blood_bank/screens/user/user_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser == null
          ? const SplashScreen()
          : FirebaseAuth.instance.currentUser!.email == 'admin@gmail.com'
              ? const AdminHome()
              : FirebaseAuth.instance.currentUser!.displayName == 'مستشفى'
                  ? const HospitalHome()
                  : UserHome(),
      routes: {
        SignupPage.routeName: (ctx) => SignupPage(),
        SplashScreen.routeName: (ctx) => SplashScreen(),
        SplashUser.routeName: (ctx) => SplashUser(),
        AdminLogin.routeName: (ctx) => AdminLogin(),
        AdminHome.routeName: (ctx) => AdminHome(),
        AdminHospitals.routeName: (ctx) => AdminHospitals(),
        AddHospital.routeName: (ctx) =>AddHospital(),
        AddBag.routeName: (ctx) =>AddBag(),
        UsersApp.routeName: (ctx) =>UsersApp(),
        HospitalHome.routeName: (ctx) =>HospitalHome(),
        UserHome.routeName: (ctx) =>UserHome(),
        UserLogin.routeName: (ctx) =>UserLogin(),
        HospitalLogin.routeName: (ctx) =>HospitalLogin(),
        DonationPage.routeName: (ctx) =>DonationPage(),
        UserDonators.routeName: (ctx) =>UserDonators(),
        HospitalDonators.routeName: (ctx) =>HospitalDonators(),
        BloodTypes.routeName: (ctx) =>BloodTypes(),
        BagRequest.routeName: (ctx) =>BagRequest(),
        HospitalRequests.routeName: (ctx) =>HospitalRequests(),
       


      },
    );
  }
}

