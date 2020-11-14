import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Auth.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  getUserSession() async {
    await Provider.of<Auth>(context, listen: false).autoLogin();
    Navigator.of(context).pushNamed('/dashboard');
  }

  @override
  void initState() {
    super.initState();
    print(getUserSession());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset('assets/splash/chef.json'),
      ),
    );
  }
}
