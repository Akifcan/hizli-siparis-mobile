import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hizli_siparis/constants/urls.dart';
import 'package:hizli_siparis/core/SharedManager.dart';
import 'package:hizli_siparis/models/active_order_model.dart';
import 'package:hizli_siparis/models/menu_model.dart';
import 'package:hizli_siparis/models/order_model.dart';
import 'package:hizli_siparis/models/table_model.dart';
import 'package:hizli_siparis/utils/utils.dart';
import 'package:toast/toast.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Service extends ChangeNotifier {
  final SharedManager sharedManager = SharedManager();
  List<MenuModel> menus = [];
  List<TableModel> tables = [];
  List<OrderModel> orderFoods = [];
  List<ActiveOrderModel> activeOrders = [];
  num ordersPrice = 0;

  getMenus() async {
    final data = await httpRequest(
        'menu',
        Map<String, String>.from(
            {"Authorization": await sharedManager.getValue('restaurantKey')}));
    if (data['status']) {
      List menuData = data['menus'];
      menus = menuData.map((menu) => MenuModel.fromJson(menu)).toList();
    }
    notifyListeners();
  }

  getTables() async {
    final data = await httpRequest(
        'table',
        Map<String, String>.from({
          "Authorization": await sharedManager.getValue('restaurantKey'),
          "fromuser": "true"
        }));
    if (data['status']) {
      List tableData = data['tables'];
      tables = tableData.map((table) => TableModel.fromJson(table)).toList();
    }
    notifyListeners();
  }

  addToOrderList(MenuModel menuModel, TableModel tableModel, context) async {
    var itemisExits = orderFoods.firstWhere(
        (element) => element.model.id == menuModel.id,
        orElse: () => null);
    if (itemisExits == null) {
      orderFoods.add(OrderModel(
          table: tableModel,
          model: menuModel,
          price: menuModel.price,
          quantity: 1));
      Toast.show("Sipariş Listesine Eklenmiştir Toplam Adet: 1 ", context,
          duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
      ordersPrice += menuModel.price;
    } else {
      print(itemisExits.model.title);
      itemisExits.quantity++;
      itemisExits.price += itemisExits.model.price;
      ordersPrice += itemisExits.model.price;
      Toast.show(
          "Sipariş Listesine Eklenmiştir Toplam Adet: ${itemisExits.quantity} ",
          context,
          duration: Toast.LENGTH_SHORT,
          gravity: Toast.BOTTOM);
    }

    print(ordersPrice);

    notifyListeners();
  }

  updatePrice(index, newPrice) {
    if (newPrice == setPrice.INCREASE) {
      orderFoods[index].quantity += 1;
      orderFoods[index].price += orderFoods[index].model.price;
      ordersPrice += orderFoods[index].model.price;
    } else if (newPrice == setPrice.DECREASE) {
      orderFoods[index].quantity -= 1;
      orderFoods[index].price -= orderFoods[index].model.price;
      ordersPrice -= orderFoods[index].model.price;
      if (orderFoods[index].quantity == 0) {
        ordersPrice -= orderFoods[index].model.price;
        orderFoods.removeAt(index);
      }
    }
    notifyListeners();
  }

  Future confirmOrder() async {
    final restaurantKey = await sharedManager.getValue('restaurantKey');
    final userKey = await sharedManager.getValue('userKey');
    Map result = {};

    for (final intihar in orderFoods) {
      final response = await http.post('$apiUrl/order/create-order', headers: {
        "restaurantAuthorization": restaurantKey,
        "userAuthorization": userKey
      }, body: {
        "quantity": intihar.quantity.toString(),
        "table": intihar.table.id,
        "menu": intihar.model.id
      });
      final data = jsonDecode(response.body);
      result = data;
    }
    return result;
  }

  clearOrders() {
    this.ordersPrice = 0;
    this.orderFoods = [];
    notifyListeners();
  }

  Future getActiveOrders() async {
    final data = await httpRequest(
        'order',
        Map<String, String>.from(
            {"Authorization": await sharedManager.getValue('restaurantKey')}));
    if (data['status']) {
      List orderData = data['orders'];
      activeOrders =
          orderData.map((order) => ActiveOrderModel.fromJson(order)).toList();
    }
    notifyListeners();
  }
}

class OrderRequest {
  IO.Socket socket;
  final SharedManager sharedManager = SharedManager();

  static final OrderRequest _orderRequest = OrderRequest._internal();

  factory OrderRequest() {
    return _orderRequest;
  }

  OrderRequest._internal() {
    print('intihar et');
    this.socket = IO.io(apiUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
  }

  sendOrderRequest(String tableId) async {
    String restaurantChannel =
        await sharedManager.getValue('restaurantChannel');
    print(restaurantChannel);
    this.socket.emit(
        'sendOrderRequest', {"tableId": tableId, "channel": restaurantChannel});
  }

  orderIsReady(context) {
    print('lütfen öldür kendini rica ediyorum:)');
    this.socket.on('sendOrderIsReady', (val) {
      print(val);
      return showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              title: Text('Sipariş'),
              content: Text(val),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Tamam'),
                )
              ],
            );
          });
    });
  }
}

enum setPrice { INCREASE, DECREASE }
