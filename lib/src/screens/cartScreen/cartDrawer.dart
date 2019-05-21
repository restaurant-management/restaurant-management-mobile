import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/cartFooter.dart';
import 'widgets/cartHeader.dart';
import 'widgets/cartList.dart';

class CartDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.1;
    final footerHeight = screenHeight * 0.15;
    return Drawer(
      child: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).colorScheme.background,
            child: CartList(
              justView: false,
              headerHeight: headerHeight,
              footerHeight: footerHeight,
              items: ['', '', '', '', '', '', '', '', '', '', '', ''],
            ),
          ),
          SizedBox(
            height: footerHeight,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: CartHeader(
              height: headerHeight,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CartFooter(
              height: footerHeight,
            ),
          )
        ]),
      ),
    );
  }
}
