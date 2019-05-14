import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingButton.dart';

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
    return LoadingButton(
      height: 50,
      width: MediaQuery.of(context).size.width,
      widthTurnOnIcon: 120,
      onCompleted: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
