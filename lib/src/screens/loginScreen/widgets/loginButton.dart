import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color color;

  const LoginButton(
      {Key key,
      this.onPressed,
      @required this.text,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(color);
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: color != null ? color : Theme.of(context).primaryColor,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ));
  }
}
