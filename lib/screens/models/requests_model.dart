import 'package:flutter/cupertino.dart';

class Requests {
  Requests({
    String? id,
    String? hospitalName,
    String? name,
    String? hospitalUid,
    String? phoneNumber,
    String? type,
    int? quantity,
  }) {
    _id = id;
    _hospitalName = hospitalName;
    _name = name;
    _hospitalUid = hospitalUid;
    _phoneNumber = phoneNumber;
    _type = type;
    _quantity = quantity;
  }

  Requests.fromJson(dynamic json) {
    _id = json['id'];
    _hospitalName = json['hospitalName'];
    _name = json['name'];
    _hospitalUid = json['hospitalUid'];
    _phoneNumber = json['phoneNumber'];
    _type = json['type'];
    _quantity = json['quantity'];
  }

  String? _id;
  String? _hospitalName;
  String? _name;
  String? _hospitalUid;
  String? _phoneNumber;
  String? _type;
  int? _quantity;

  String? get id => _id;
  String? get hospitalName => _hospitalName;
  String? get name => _name;
  String? get hospitalUid => _hospitalUid;
  String? get phoneNumber => _phoneNumber;
  String? get type => _type;
  int? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hospitalName'] = _hospitalName;
    map['name'] = _name;
    map['hospitalUid'] = _hospitalUid;
    map['phoneNumber'] = _phoneNumber;
    map['type'] = _type;
    map['quantity'] = _quantity;

    return map;
  }
}