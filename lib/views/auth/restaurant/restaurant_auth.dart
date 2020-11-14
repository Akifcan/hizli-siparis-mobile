import 'package:flutter/material.dart';
import 'package:hizli_siparis/theme/custom_theme.dart';
import 'package:hizli_siparis/widgets/buttons/custom_raised_icon_button.dart';
import './restaurant_auth_viewmodel.dart';

class RestaurantAuth extends StatefulWidget {
  RestaurantAuth({Key key}) : super(key: key);

  @override
  _RestaurantAuthState createState() => _RestaurantAuthState();
}

class _RestaurantAuthState extends RestaurantAuthViewModel {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: authTheme,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
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
                    _joinHizliSiparis
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
          Text('Restoran Girişi',
              style: Theme.of(context)
                  .textTheme
                  .headline4
                  .copyWith(color: Colors.white)),
          Image.asset('assets/images/auth.png', height: 150)
        ],
      );

  Widget get _form => Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Lütfen restoran adını girin';
                }
                return null;
              },
              onChanged: (val) => setState(() => restaurantName = val),
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  hintText: 'Restoran Adı',
                  prefixIcon: Icon(
                    Icons.restaurant,
                    color: Colors.white,
                  )),
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Lütfen giriş kodunu belirtin';
                }
                if (value.trim().length > 10) {
                  return 'Giriş kodu en fazla 10 karakterdir.';
                }
                return null;
              },
              onChanged: (val) => setState(() => loginCode = val),
              decoration: InputDecoration(
                  errorStyle: TextStyle(color: Colors.white),
                  hintText: 'Giriş Kodu',
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
                      voidCallback: () => login(_formKey, _scaffoldKey),
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

  Widget get _joinHizliSiparis => RaisedButton.icon(
        color: Colors.white,
        onPressed: () {},
        icon: Icon(Icons.fiber_pin),
        label: Text("Hızlı Sipariş'e Katılın"),
      );
}
