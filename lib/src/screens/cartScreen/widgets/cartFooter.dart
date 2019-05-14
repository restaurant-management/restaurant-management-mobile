import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'summaryBill.dart';

class CartFooter extends StatelessWidget {
  final double height;
  final bool hasCreateButton;

  const CartFooter({Key key,@required this.height, this.hasCreateButton = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Container(
      height: height,
      color: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SummaryBill(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GradientButton(
              increaseWidthBy: 100,
              child: Text('Tạo hoá đơn'),
              gradient: LinearGradient(
                colors: <Color>[
                  const Color.fromRGBO(88, 39, 176, 1),
                  const Color.fromRGBO(0, 39, 176, 1),
                ],
                stops: [0.1, 1.0],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
              ),
              callback: () {},
            ),
          )
        ],
      ),
    );
  }
}