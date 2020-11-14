import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/models/menu_model.dart';
import 'package:hizli_siparis/models/table_model.dart';
import 'package:hizli_siparis/views/order/order_list.dart';
import 'package:provider/provider.dart';

class SelectItems extends StatefulWidget {
  final TableModel tableModel;

  SelectItems({@required this.tableModel});

  @override
  _SelectItemsState createState() => _SelectItemsState();
}

class _SelectItemsState extends State<SelectItems> {
  navigateToOrderList() {
    print(widget.tableModel.tableRow);
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => OrderList(tableId: widget.tableModel.id)));
  }

  addToOrderList(MenuModel menuModel, TableModel tableModel) {
    Provider.of<Service>(context, listen: false)
        .addToOrderList(menuModel, tableModel, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar,
        bottomNavigationBar: _bottomNavigationBar,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Column(
            children: <Widget>[_menuList],
          ),
        ));
  }

  Widget get _appBar => AppBar(
        title: Text(
            '${widget.tableModel.tableName} - ${widget.tableModel.tableRow} Sipariş Oluştur'),
      );

  Widget get _menuList => Expanded(
        child: ListView.separated(
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: Provider.of<Service>(context, listen: false).menus.length,
          itemBuilder: (context, index) => ListTile(
            onTap: () => addToOrderList(
                Provider.of<Service>(context, listen: false).menus[index],
                widget.tableModel),
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
      );

  Widget get _bottomNavigationBar => Container(
        height: 100,
        color: Colors.indigo,
        child: GestureDetector(
          onTap: () {
            navigateToOrderList();
          },
          child: Row(
            children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.restaurant_menu,
                  size: 40,
                ),
              ),
              Expanded(
                  child: Text('Siparişleri Onayla',
                      style: Theme.of(context).textTheme.headline5)),
            ],
          ),
        ),
      );
}
