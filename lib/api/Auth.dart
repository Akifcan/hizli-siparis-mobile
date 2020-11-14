import 'package:flutter/material.dart';
import 'package:hizli_siparis/core/SharedManager.dart';
import 'package:http/http.dart' as http;
import '../constants/urls.dart';
import 'dart:convert';

class Auth extends ChangeNotifier {
  Map restaurant = {};
  Map user = {};
  SharedManager sharedManager = SharedManager();

  restaurantLogin(Map restaurantDetail) async {
    final response = await http.post('$apiUrl/user/restaurant-login',
        body: restaurantDetail);
    final data = jsonDecode(response.body);
    if (data['status']) {
      sharedManager.save('restaurantChannel', data['user']['_id']);
      sharedManager.save('restaurantKey', data['token']);
    }
    return {"status": data['status'], "message": data['message']};
  }

  userLogin(Map userDetail) async {
    final restaurantKey = await sharedManager.getValue('restaurantKey');
    final response = await http.post('$apiUrl/user/login',
        body: userDetail, headers: {"Authorization": restaurantKey});
    final data = jsonDecode(response.body);
    print(data);
    if (data['status']) {
      sharedManager.save('userKey', data['token']);
    }
    return {"status": data['status'], "message": data['message']};
  }

  autoLogin() async {
    final restaurantKey = await sharedManager.getValue('restaurantKey');
    final userKey = await sharedManager.getValue('userKey');

    final restaurantResponse = await http.get("$apiUrl/restaurant/current-user",
        headers: {"Authorization": restaurantKey});

    final userResponse = await http
        .get("$apiUrl/user/current-user", headers: {"Authorization": userKey});

    final restaurantData = jsonDecode(restaurantResponse.body);
    final userData = jsonDecode(userResponse.body);

    this.restaurant = restaurantData['user'];
    sharedManager.save('restaurantChannel', restaurantData['user']['_id']);
    this.user = userData['user'];

    notifyListeners();
  }

  autoRedirect(context) async {
    final restaurantKey = await sharedManager.getValue('restaurantKey');
    final userKey = await sharedManager.getValue('userKey');
    if (userKey != null && restaurantKey != null) {
      Navigator.of(context).pushNamed('/splash');
    } else if (restaurantKey != null) {
      Navigator.of(context).pushNamed('/user-login');
    }
  }
}
