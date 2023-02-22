import 'package:flutter/cupertino.dart';

class Hospitals {
  Hospitals({
    String? id,
    String? uid,
    String? name,
    String? email,
    String? password,
  }) {
    _id = id;
    _uid = uid;
    _name = name;
    _email = email;
    _password = password;
  }

  Hospitals.fromJson(dynamic json) {
    _id = json['id'];
    _uid = json['uid'];
    _name = json['name'];
    _email = json['email'];
    _password = json['password'];
  }

  String? _id;
  String? _uid;
  String? _name;
  String? _email;
  String? _password;

  String? get id => _id;
  String? get uid => _uid;
  String? get name => _name;
  String? get email => _email;
  String? get password => _password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['uid'] = _uid;
    map['name'] = _name;
    map['email'] = _email;
    map['password'] = _password;

    return map;
  }
}