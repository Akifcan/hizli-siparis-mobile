import 'package:flutter/material.dart';

class ActiveOrderModel {
  final String id;
  final num price;
  final num quantity;
  final Map table;
  final Map menu;

  ActiveOrderModel(
      {@required this.id,
      @required this.price,
      @required this.quantity,
      @required this.table,
      @required this.menu});

  factory ActiveOrderModel.fromJson(Map json) {
    return ActiveOrderModel(
        id: json['_id'],
        price: json['price'],
        quantity: json['quantity'],
        table: json['tables'][0],
        menu: json['menu']);
  }
}
