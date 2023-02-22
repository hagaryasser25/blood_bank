import 'package:blood_bank/screens/hospital/hospital_home.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:ndialog/ndialog.dart';

import '../admin/admin_home.dart';
import '../user/user_home.dart';


class UserLogin extends StatefulWidget {
  static const routeName = '/userLogin';
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  var passwordController = TextEditingController();
  var emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, child) => Scaffold(
          body: Container(
            color: Colors.white,
            child: Column(children: [
              SizedBox(height: 80.h,),
              Padding(
                padding:  EdgeInsets.only(
                  right: 35.w,
                  left: 35.w
                ),
                child: Image.asset('assets/images/logo.jfif'),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10.w, left: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          'تسجيل دخول',
                          style: TextStyle(
                              fontSize: 22, ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: emailController,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 225, 60, 48)
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color.fromARGB(255, 225, 60, 48)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color.fromARGB(255, 225, 60, 48)),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'البريد الألكترونى',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 25.h,
                        ),
                        SizedBox(
                          height: 65.h,
                          child: TextField(
                            style: TextStyle(),
                            controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.password,
                                  color: Color.fromARGB(255, 225, 60, 48),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color.fromARGB(255, 225, 60, 48)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  borderSide: BorderSide(
                                      width: 1.0, color: Color.fromARGB(255, 225, 60, 48)),
                                ),
                                border: OutlineInputBorder(),
                                hintText: 'كلمة المرور',
                                hintStyle: TextStyle()),
                          ),
                        ),
                        SizedBox(
                          height: 30.h,
                        ),
                        ConstrainedBox(
                          constraints: BoxConstraints.tightFor(
                              width: double.infinity, height: 50.h),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 225, 60, 48),
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25), // <-- Radius
                              ),
                            ),
                            child: Text(
                              'سجل دخول',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();

                              if (email.isEmpty || password.isEmpty) {
                                CherryToast.info(
                                    title: Text('Please fill all fields'),
                                    actionHandler: () {},
                                  ).show(context);
                                return;
                              }


                              ProgressDialog progressDialog = ProgressDialog(
                                  context,
                                  title: Text('Logging In'),
                                  message: Text('Please Wait'));
                              progressDialog.show();

                              try {
                                FirebaseAuth auth = FirebaseAuth.instance;
                                UserCredential userCredential =
                                    await auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                if (userCredential.user != null) {
                                  progressDialog.dismiss();
                                  Navigator.pushNamed(
                                      context, UserHome.routeName);
                                }
                              } on FirebaseAuthException catch (e) {
                                progressDialog.dismiss();
                                if (e.code == 'user-not-found') {
                                  CherryToast.info(
                                    title: Text('User not found'),
                                    actionHandler: () {},
                                  ).show(context);
                                } else if (e.code == 'wrong-password') {
                                  CherryToast.info(
                                    title: Text('Wrong email or password'),
                                    actionHandler: () {},
                                  ).show(context);
                                }
                              } catch (e) {
                                CherryToast.info(
                                    title: Text('Something went wrong'),
                                    actionHandler: () {},
                                  ).show(context);
                                progressDialog.dismiss();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}