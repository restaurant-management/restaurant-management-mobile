import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/models/cartDishModel.dart';

import 'dishItem.dart';

class DishList extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;
  final bool justView;

  const DishList(
      {Key key, this.headerHeight, this.footerHeight, this.justView = true})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  final CartBloc _cartBloc = CartBloc();

  List<CartDishModel> get items => _cartBloc.currentCart.listDishes;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  bool get justView => widget.justView;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index].dishId.toString();
          if (index == 0)
            return Column(
              children: <Widget>[
                headerHeight != null
                    ? SizedBox(
                        height: headerHeight,
                      )
                    : Container(),
                justView
                    ? DishItem(
                        canChangeQuantity: !justView,
                      )
                    : Dismissible(
                        key: Key(item),
                        child: DishItem(),
                      ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                justView
                    ? DishItem(
                        canChangeQuantity: !justView,
                      )
                    : Dismissible(
                        key: Key(item),
                        child: DishItem(),
                      ),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return justView
              ? DishItem(
                  canChangeQuantity: !justView,
                )
              : Dismissible(key: Key(item), child: DishItem());
        });
  }
}
