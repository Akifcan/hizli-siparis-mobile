import 'package:flutter/material.dart';

class TableModel {
  final String id;
  final String restaurant;
  final num tableRow;
  final String tableName;

  TableModel(
      {@required this.id,
      @required this.restaurant,
      @required this.tableName,
      @required this.tableRow});

  factory TableModel.fromJson(Map json) {
    return TableModel(
        id: json['_id'],
        restaurant: json['restaurant'],
        tableName: json['tableName'],
        tableRow: json['tableRow']);
  }
}
