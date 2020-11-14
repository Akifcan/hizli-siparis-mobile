import 'package:flutter/material.dart';
import 'package:hizli_siparis/theme/custom_theme.dart';
import 'package:hizli_siparis/views/auth/user/user_auth_viewmodel.dart';
import 'package:hizli_siparis/widgets/buttons/custom_raised_icon_button.dart';

class UserAuth extends StatefulWidget {
  UserAuth({Key key}) : super(key: key);

  @override
  _UserAuthState createState() => _UserAuthState();
}

class _UserAuthState extends UserAuthViewModel {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: authTheme,
      child: SafeArea(
        child: Scaffold(
          key: scaffoldKey,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    _title,
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                    _form,
                    SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget get _title => Column(
        children: <Widget>[
          Text('Hızlı Sipariş',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white)),
          Text('Kullanıcı Girişi',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white)),
          Image.asset('assets/images/auth.png', height: 150)
        ],
      );

  Widget get _form => Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Lütfen isminizi belirtin' : null,
              onChanged: (val) => setState(() => username = val),
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  hintText: 'Kullanıcı Adı',
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (val) =>
                  val.isEmpty ? 'Lütfen isminizi belirtin' : null,
              onChanged: (val) => setState(() => password = val),
              obscureText: true,
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  hintText: 'Şifreniz',
                  prefixIcon: Icon(Icons.fiber_pin, color: Colors.white)),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: CustomRaisedIconButton(
                      text: 'Giriş Yap',
                      iconData: Icons.phonelink_lock,
                      voidCallback: () => login(),
                      color: Colors.white,
                      textColor: Colors.black),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: CustomRaisedIconButton(
                      text: 'Kodum Nerede',
                      iconData: Icons.store,
                      voidCallback: () {
                        print('kodum nerede');
                      },
                      color: Colors.white,
                      textColor: Colors.black),
                )
              ],
            )
          ],
        ),
      );
}
