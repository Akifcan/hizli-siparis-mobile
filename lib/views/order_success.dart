import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key key}) : super(key: key);

  @override
  _OrderSuccessState createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {
  redirectBack() {
    Timer(Duration(seconds: 3),
        () => Navigator.of(context).pushReplacementNamed('/dashboard'));
  }

  @override
  void initState() {
    super.initState();
    redirectBack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/splash/order-success.json'),
          Text('Sipariş mutfağa gönderilmiştir',
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black))
        ],
      )),
    );
  }
}
