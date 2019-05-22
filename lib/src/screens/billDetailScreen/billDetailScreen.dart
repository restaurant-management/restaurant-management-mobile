import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

import 'widgets/dishList.dart';
import 'widgets/summaryBill.dart';

class BillDetailScreen extends StatefulWidget {
  final BillModel bill;

  const BillDetailScreen({Key key, @required this.bill})
      : assert(bill != null),
        super(key: key);

  @override
  _BillDetailScreenState createState() => _BillDetailScreenState();
}

class _BillDetailScreenState extends State<BillDetailScreen> {
  BillModel get bill => widget.bill;

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
      bottomNavigationBar: SizedBox(
          height: 56,
          child: SummaryBill(
            billDetails: bill.billDetails,
          )),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Container(
            color: Theme.of(context).colorScheme.background,
            child: DishList(
              headerHeight: 10,
              billDetails: bill.billDetails,
            ),
          ),
        ]),
      ),
    );
  }
}
