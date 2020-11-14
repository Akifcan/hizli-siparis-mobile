import 'package:flutter/material.dart';
import 'package:hizli_siparis/api/Service.dart';
import 'package:hizli_siparis/models/table_model.dart';
import 'package:hizli_siparis/views/order/select_items.dart';
import 'package:provider/provider.dart';

class SelectTable extends StatefulWidget {
  SelectTable({Key key}) : super(key: key);

  @override
  _SelectTableState createState() => _SelectTableState();
}

class _SelectTableState extends State<SelectTable> {
  selectItems(TableModel tableModel) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => SelectItems(tableModel: tableModel)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _title,
            _infoText,
            SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: Provider.of<Service>(context).tables.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => selectItems(
                      Provider.of<Service>(context, listen: false)
                          .tables[index]),
                  contentPadding: const EdgeInsets.all(0),
                  title: Text(
                      'Masa Adı: ${Provider.of<Service>(context).tables[index].tableName}'),
                  subtitle: Text(
                    'Masa Numarası: ${Provider.of<Service>(context).tables[index].tableRow}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  trailing: FlatButton(
                    color: Colors.white,
                    onPressed: () => selectItems(
                        Provider.of<Service>(context, listen: false)
                            .tables[index]),
                    child: Text('Bu masayı seç'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget get _appBar => AppBar(
        title: Text('Sipariş Oluştur'),
        centerTitle: true,
      );

  Widget get _title => Text(
        'Siparişi alacak masayı seçin',
        style: Theme.of(context).textTheme.headline4,
      );
  Widget get _infoText => Text(
        'Şu anda boş olan masalar',
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(color: Colors.blue[800]),
      );
}
