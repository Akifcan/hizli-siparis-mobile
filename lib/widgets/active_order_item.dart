import 'package:flutter/material.dart';

class ActiveOrderItem extends StatelessWidget {
  final String text;
  ActiveOrderItem({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            text,
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }
}
