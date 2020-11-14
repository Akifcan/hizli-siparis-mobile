import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final VoidCallback voidCallback;
  final Color color;

  CustomCard(
      {@required this.title,
      @required this.iconData,
      @required this.voidCallback,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: this.voidCallback,
        child: Container(
          decoration: BoxDecoration(
              color: this.color, borderRadius: BorderRadius.circular(20)),
          height: MediaQuery.of(context).size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(this.iconData, size: 50),
              SizedBox(height: 5),
              Text(this.title,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
