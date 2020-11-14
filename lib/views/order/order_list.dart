import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/models/order_model.dart';
import 'package:provider/provider.dart';

class OrderList extends StatefulWidget {
  final String tableId;
  OrderList({@required this.tableId});

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  OrderRequest orderRequest = OrderRequest();

  confirmOrder() async {
    final result =
        await Provider.of<Service>(context, listen: false).confirmOrder();
    if (result['status']) {
      Provider.of<Service>(context, listen: false).clearOrders();
      Provider.of<Service>(context, listen: false).getTables();
      orderRequest.sendOrderRequest(widget.tableId);
      Navigator.of(context).pushReplacementNamed('/order-success');
      scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text(result['message'])));
    }
  }

  updatePrice(index, setPrice) {
    Provider.of<Service>(context, listen: false).updatePrice(index, setPrice);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: _appBar,
        body: _orders,
        bottomNavigationBar: _bottomNavigationBar);
  }

  Widget get _appBar => AppBar(
        centerTitle: true,
        title: Text('Sipariş Listesi'),
      );

  Widget get _orders => ListView.builder(
      itemCount: Provider.of<Service>(context).orderFoods.length,
      itemBuilder: (context, index) {
        OrderModel order = Provider.of<Service>(context).orderFoods[index];
        return ListTile(
          title: Text(order.model.title),
          subtitle: Text(
              'Birim fiyatı: ${order.model.price} - Adet ${order.quantity} - Toplam Fiyat: ${order.price} '),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => updatePrice(index, setPrice.INCREASE),
                child: Icon(
                  Icons.add,
                ),
              ),
              GestureDetector(
                onTap: () => updatePrice(index, setPrice.DECREASE),
                child: Icon(
                  Icons.remove,
                ),
              )
            ],
          ),
        );
      });

  Widget get _bottomNavigationBar => Container(
        padding: const EdgeInsets.all(20),
        height: 70,
        color: Colors.indigo,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Text(
                'Toplam Tutar ${Provider.of<Service>(context, listen: false).ordersPrice}',
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(color: Colors.white),
              ),
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  confirmOrder();
                },
                child: Text('Siparişi Onayla'),
              ),
            )
          ],
        ),
      );
}
