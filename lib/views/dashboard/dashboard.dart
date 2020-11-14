import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/constants/urls.dart';
import 'package:hizli_siparis/views/dashboard/dashboard_viewmodel.dart';
import 'package:hizli_siparis/views/order_ready.dart';
import 'package:hizli_siparis/widgets/cards/custom_card.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends DashboardViewModel {
  @override
  void initState() {
    super.initState();
    Provider.of<Service>(context, listen: false).getMenus();
    Provider.of<Service>(context, listen: false).getTables();
    Provider.of<Service>(context, listen: false).getActiveOrders();
    OrderRequest orderRequest = OrderRequest();
    IO.Socket socket = IO.io(apiUrl, <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('sendOrderIsReady', (val) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => OrderReady(val: val)));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
        child: SafeArea(
          child: Column(
            children: <Widget>[_orders, _menu],
          ),
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        centerTitle: true,
        title: Text('Hızlı Sipariş'),
      );

  Widget get _orders => Row(
        children: <Widget>[
          Expanded(
            child: CustomCard(
              title: 'Sipariş Oluştur',
              voidCallback: () =>
                  Navigator.of(context).pushNamed('/create-order'),
              color: Colors.green[900],
              iconData: Icons.restaurant_menu,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: CustomCard(
              title: 'Mevcut Siparişler',
              voidCallback: () =>
                  Navigator.of(context).pushNamed('/active-orders'),
              color: Colors.green[700],
              iconData: Icons.bookmark,
            ),
          ),
        ],
      );

  Widget get _menu => Row(
        children: <Widget>[
          Expanded(
            child: CustomCard(
              title: 'Menü',
              color: Colors.green[500],
              iconData: Icons.book,
              voidCallback: () => Navigator.of(context).pushNamed('/menu'),
            ),
          )
        ],
      );
}
