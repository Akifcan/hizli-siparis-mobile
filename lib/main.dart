import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Auth.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/theme/custom_theme.dart';
import 'package:hizli_siparis/views/auth/restaurant/restaurant_auth.dart';
import 'package:hizli_siparis/views/auth/user/user_auth.dart';
import 'package:hizli_siparis/views/dashboard/dashboard.dart';
import 'package:hizli_siparis/views/menu.dart';
import 'package:hizli_siparis/views/order/active_orders.dart';
import 'package:hizli_siparis/views/order/select_table.dart';
import 'package:hizli_siparis/views/order_success.dart';
import 'package:hizli_siparis/views/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => Auth(),
      ),
      ChangeNotifierProvider(
        create: (context) => Service(),
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hızlı Sipariş',
      theme: mainTheme,
      debugShowCheckedModeBanner: false,
      home: RestaurantAuth(),
      routes: {
        '/menu': (context) => Menu(),
        '/dashboard': (context) => Dashboard(),
        '/create-order': (context) => SelectTable(),
        '/active-orders': (context) => ActiveOrders(),
        '/order-success': (context) => OrderSuccess(),
        '/splash': (context) => Splash(),
        '/user-login': (context) => UserAuth()
      },
    );
  }
}
