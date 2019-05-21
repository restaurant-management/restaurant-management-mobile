import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'cartItem.dart';

class CartList extends StatefulWidget {
  final List<String> items;
  final double headerHeight;
  final double footerHeight;
  final bool justView;

  const CartList(
      {Key key,
      @required this.items,
      this.headerHeight,
      this.footerHeight,
      this.justView = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => CartListState();
}

class CartListState extends State<CartList> {
  // TODO Create and change type for cart item

  List<String> get items => widget.items;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  bool get justView => widget.justView;

  CartListState();

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
                justView
                    ? CartItem(canChangeQuantity: !justView,)
                    : Dismissible(key: Key(item), child: CartItem()),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                justView
                    ? CartItem(canChangeQuantity: !justView,)
                    : Dismissible(key: Key(item), child: CartItem()),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return justView
              ? CartItem(canChangeQuantity: !justView,)
              : Dismissible(key: Key(item), child: CartItem());
        });
  }
}
