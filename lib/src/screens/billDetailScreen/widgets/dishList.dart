import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/models/billDetailModel.dart';

import 'dishItem.dart';

class DishList extends StatefulWidget {
  final double headerHeight;
  final double footerHeight;
  final List<BillDetailModel> billDetails;

  const DishList(
      {Key key,
      this.headerHeight,
      this.footerHeight,
      @required this.billDetails})
      : assert(billDetails != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => _DishListState();
}

class _DishListState extends State<DishList> {
  List<BillDetailModel> get items => widget.billDetails;

  double get headerHeight => widget.headerHeight;

  double get footerHeight => widget.footerHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (context, index) {
          if (index == 0)
            return Column(
              children: <Widget>[
                headerHeight != null
                    ? SizedBox(
                        height: headerHeight,
                      )
                    : Container(),
                DishItem(
                  billDetailModel: items[index],
                ),
              ],
            );
          else if (index == items.length - 1)
            return Column(
              children: <Widget>[
                DishItem(
                  billDetailModel: items[index],
                ),
                footerHeight != null
                    ? SizedBox(
                        height: footerHeight + 8,
                      )
                    : Container(),
              ],
            );
          return DishItem(
            billDetailModel: items[index],
          );
        });
  }
}
