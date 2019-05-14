import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SecondaryCartButton extends StatelessWidget {
  final Color color;
  final int count;

  const SecondaryCartButton({Key key, this.color, this.count = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Stack(children: <Widget>[
        FloatingActionButton(
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.shopping_cart,
            color: color != null ? color : Colors.white,
          ),
        ),
        Positioned(
          top: 7,
          right: 7,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Icon(
                Icons.brightness_1,
                color: Colors.red,
                size: 20,
              ),
              Text(
                count.toString(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        )
      ]),
    );
  }
}
