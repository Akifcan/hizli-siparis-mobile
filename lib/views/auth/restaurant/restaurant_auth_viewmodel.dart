import 'package:flutter/material.dart';
import './restaurant_auth.dart';
import '../../../api/Auth.dart';
import '../../../core/SharedManager.dart';

abstract class RestaurantAuthViewModel extends State<RestaurantAuth> {
  String restaurantName = '';
  String loginCode = '';
  Auth auth = Auth();
  SharedManager sharedManager = SharedManager();

  login(formKey, scaffoldKey) async {
    if (formKey.currentState.validate()) {
      final result = await auth.restaurantLogin(
          {"title": restaurantName.trim(), "loginCode": loginCode.trim()});
      if (result['status'] == true) {
        Navigator.of(context).pushNamed('/user-login');
      } else {
        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: Text(result['message'])));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() => auth.autoRedirect(context));
  }
}
