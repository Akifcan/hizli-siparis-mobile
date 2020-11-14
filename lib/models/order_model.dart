import 'package:flutter/material.dart';
import 'package:hizli_siparis/models/menu_model.dart';
import 'package:hizli_siparis/models/table_model.dart';

class OrderModel {
  MenuModel model;
  TableModel table;
  num quantity;
  num price;

  OrderModel(
      {@required this.model,
      @required this.table,
      @required this.quantity,
      @required this.price});
}
