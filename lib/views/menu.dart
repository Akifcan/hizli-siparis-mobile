import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:provider/provider.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemCount:
                      Provider.of<Service>(context, listen: false).menus.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(Provider.of<Service>(context, listen: false)
                        .menus[index]
                        .title),
                    trailing: CircleAvatar(
                      radius: 30,
                      child: Text(Provider.of<Service>(context, listen: false)
                              .menus[index]
                              .price
                              .toString() +
                          'TL'),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget get _appBar => AppBar(
        centerTitle: true,
        title: Text('Menü'),
      );
}
