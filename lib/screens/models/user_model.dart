import 'package:flutter/cupertino.dart';

class Users {
  Users({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? phoneNumber,
    String? role,
  }) {
    _id = id;
    _uid = uid;
    _name = name;
    _email = email;
    _phoneNumber = phoneNumber;
    _role = role;
  }

  Users.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _phoneNumber = json['phoneNumber'];
    _role = json['role'];
  }

  String? _id;
  String? _uid;
  String? _name;
  String? _email;
  String? _phoneNumber;
  String? _role;

  String? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get phoneNumber => _phoneNumber;
  String? get role => _role;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['name'] = _name;
    map['email'] = _email;
    map['phoneNumber'] = _phoneNumber;
    map['role'] = _role;

    return map;
  }
}