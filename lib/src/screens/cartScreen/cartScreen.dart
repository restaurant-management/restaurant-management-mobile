import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/cartList.dart';

import 'widgets/summaryBill.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Danh sách món',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      bottomNavigationBar: SizedBox(height: 56, child: SummaryBill()),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).colorScheme.background,
            child: CartList(
              items: ['', '', '', '', '', '', '', '', '', '', '', ''],
            ),
          ),
        ]),
      ),
    );
  }
}
