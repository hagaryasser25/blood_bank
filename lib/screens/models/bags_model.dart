import 'package:flutter/cupertino.dart';

class Bags {
  Bags({
    String? id,
    String? hospitalUid,
    int? quantity,
    String? type,
  }) {
    _id = id;
    _hospitalUid = hospitalUid;
    _quantity = quantity;
    _type = type;
  }

  Bags.fromJson(dynamic json) {
    _id = json['id'];
    _hospitalUid = json['hospitalUid'];
    _quantity = json['quantity'];
    _type = json['type'];
  }

  String? _id;
  String? _hospitalUid;
  int? _quantity;
  String? _type;

  String? get id => _id;
  String? get hospitalUid => _hospitalUid;
  int? get quantity => _quantity;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['hospitalUid'] = _hospitalUid;
    map['quantity'] = _quantity;
    map['type'] = _type;


    return map;
  }
}