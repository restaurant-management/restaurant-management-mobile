import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String message;
  final VoidCallback reloadOnPressed;

  const ErrorIndicator({Key key, this.message, this.reloadOnPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  message ?? '',
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                reloadOnPressed != null
                    ? FlatButton(
                        child: Text(
                          'Tải lại',
                          style: TextStyle(fontSize: 18),
                        ),
                        onPressed: () {
                          reloadOnPressed();
                        },
                      )
                    : Container()
              ],
            ),
          ),
        ),
      );
}
