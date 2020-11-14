import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OrderReady extends StatefulWidget {
  final String val;

  OrderReady({@required this.val});

  @override
  _OrderReadyState createState() => _OrderReadyState();
}

class _OrderReadyState extends State<OrderReady> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset('assets/splash/order-ready.json'),
          Text(widget.val,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  .copyWith(color: Colors.black))
        ],
      )),
    );
  }
}
