import 'package:flutter/cupertino.dart';

class Donators {
  Donators({
    String? id,
    String? hospitalName,
    String? name,
    String? hospitalUid,
    String? phoneNumber,
    String? type,
    String? way,
  }) {
    _id = id;
    _hospitalName = hospitalName;
    _name = name;
    _hospitalUid = hospitalUid;
    _phoneNumber = phoneNumber;
    _type = type;
    _way = way;
  }

  Donators.fromJson(dynamic json) {
    _id = json['id'];
    _hospitalName = json['hospitalName'];
    _name = json['name'];
    _hospitalUid = json['hospitalUid'];
    _phoneNumber = json['phoneNumber'];
    _type = json['type'];
    _way = json['way'];
  }

  String? _id;
  String? _hospitalName;
  String? _name;
  String? _hospitalUid;
  String? _phoneNumber;
  String? _type;
  String? _way;

  String? get id => _id;
  String? get hospitalName => _hospitalName;
  String? get name => _name;
  String? get hospitalUid => _hospitalUid;
  String? get phoneNumber => _phoneNumber;
  String? get type => _type;
  String? get way => _way;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hospitalName'] = _hospitalName;
    map['name'] = _name;
    map['hospitalUid'] = _hospitalUid;
    map['phoneNumber'] = _phoneNumber;
    map['type'] = _type;
    map['way'] = _way;

    return map;
  }
}