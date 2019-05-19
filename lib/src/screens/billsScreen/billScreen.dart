import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../widgets/AppBars/backAppBar.dart';
import 'widgets/billsListView.dart';

class BillsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppBar(showShoppingCart: false),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: BillsListView(),
      ),
    );
  }

}