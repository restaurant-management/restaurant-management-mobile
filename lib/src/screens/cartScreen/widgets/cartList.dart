import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cartItem.dart';

class CartList extends StatefulWidget {
  final List<String> items;
  final double headerHeight;
  final double footerHeight;

  const CartList(
      {Key key, @required this.items, this.headerHeight, this.footerHeight})
      : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      CartListState(items, headerHeight, footerHeight);
}

class CartListState extends State<CartList> {
  // TODO Create and change type for cart item
  final List<String> items;
  final double headerHeight;
  final double footerHeight;

  CartListState(this.items, this.headerHeight, this.footerHeight);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (index == 0)
            return Column(
              children: <Widget>[
                headerHeight != null
                    ? SizedBox(
                        height: headerHeight,
                      )
                    : Container(),
                Dismissible(key: Key(item), child: CartItem()),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                Dismissible(key: Key(item), child: CartItem()),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return Dismissible(key: Key(item), child: CartItem());
        });
  }
}
