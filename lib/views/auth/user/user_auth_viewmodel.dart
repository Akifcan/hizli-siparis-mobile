import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Auth.dart';
import 'package:hizli_siparis/views/auth/user/user_auth.dart';

abstract class UserAuthViewModel extends State<UserAuth> {
  Auth auth = Auth();
  String username = '';
  String password = '';
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  login() async {
    if (formKey.currentState.validate()) {
      final result =
          await auth.userLogin({"username": username, "password": password});
      if (result['status']) {
      } else {
        scaffoldKey.currentState
            .showSnackBar(new SnackBar(content: Text(result['message'])));
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print(auth.restaurant);
  }
}
