import 'package:flutter/material.dart';

class MenuModel {
  final String id;
  final String title;
  final String category;
  final num price;

  MenuModel(
      {@required this.id,
      @required this.title,
      @required this.category,
      @required this.price});

  factory MenuModel.fromJson(Map json) {
    return MenuModel(
        id: json['_id'],
        category: json['category'],
        title: json['title'],
        price: json['price']);
  }
}
