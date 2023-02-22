import 'package:firebase_database/firebase_database.dart';

class UsersH {
  String? email;
  String? uid;
  String? phoneNumber;
  String? name;
  String? dt;
  String? role;

  UsersH({this.email, this.uid, this.phoneNumber, this.name, this.dt, this.role});

  UsersH.fromSnapshot(DataSnapshot dataSnapshot) {
    uid = (dataSnapshot.child("uid").value.toString());
    email = (dataSnapshot.child("email").value.toString());
    name = (dataSnapshot.child("name").value.toString());
    phoneNumber = (dataSnapshot.child("phoneNumber").value.toString());
    dt = (dataSnapshot.child("dt").value.toString());
    role = (dataSnapshot.child("role").value.toString());
  }
}
