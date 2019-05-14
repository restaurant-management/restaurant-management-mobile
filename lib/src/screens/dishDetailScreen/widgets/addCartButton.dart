import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCartButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: () {},
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Thêm vào hoá đơn',
            style: TextStyle(color: Colors.white, fontSize: 20),
          )
        ],
      ),
    );
  }

}