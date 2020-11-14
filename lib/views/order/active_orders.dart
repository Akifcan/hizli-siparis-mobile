import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/models/active_order_model.dart';
import 'package:hizli_siparis/widgets/active_order_item.dart';
import 'package:provider/provider.dart';

class ActiveOrders extends StatefulWidget {
  ActiveOrders({Key key}) : super(key: key);

  @override
  _ActiveOrdersState createState() => _ActiveOrdersState();
}

class _ActiveOrdersState extends State<ActiveOrders> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: ListView.builder(
        itemCount:
            Provider.of<Service>(context, listen: false).activeOrders.length,
        itemBuilder: (context, index) {
          ActiveOrderModel order =
              Provider.of<Service>(context, listen: false).activeOrders[index];
          return ExpansionTile(
            title: Text(
                'Masa - ${order.table['tableName']} - ${order.table['tableRow']} '),
            children: <Widget>[
              ActiveOrderItem(
                text: 'Toplam Fiyat ${order.price}',
              ),
              SizedBox(height: 5),
              ActiveOrderItem(
                text: 'Toplam Adet ${order.quantity}',
              ),
              SizedBox(height: 5),
              ActiveOrderItem(
                text: 'Ürün ${order.menu['title']}',
              ),
              SizedBox(height: 5),
              ActiveOrderItem(
                text: 'Birim Fiyatı ${order.menu['price']}',
              ),
            ],
          );
        },
      ),
    );
  }

  Widget get _appBar => AppBar(
        title: Text('Aktif siparişler'),
        centerTitle: true,
      );
}
