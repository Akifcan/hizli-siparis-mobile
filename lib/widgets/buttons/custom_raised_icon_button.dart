import 'package:flutter/material.dart';

class CustomRaisedIconButton extends StatelessWidget {

  final String text;
  final IconData iconData;
  final VoidCallback voidCallback;
  final Color color;
  final Color textColor;

  CustomRaisedIconButton({@required this.text, @required this.iconData, @required this.voidCallback, @required this.color, @required this.textColor});

  @override
  Widget build(BuildContext context) {
    return RaisedButton.icon(
      textColor: this.textColor,
      label: Text(this.text),
      icon: Icon(this.iconData),
      onPressed: this.voidCallback,
      color: this.color,
    );
  }
}