import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PrimaryCartButton extends StatelessWidget {
  final Color color;
  final int count;

  const PrimaryCartButton({Key key, this.color, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Stack(children: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: color != null ? color : Theme.of(context).primaryColor,
          ),
        ),
        Positioned(
          top: 5,
          right: 5,
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
