import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/event.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

import '../../../blocs/billBloc/bloc.dart';
import 'billItem.dart';

class BillsListView extends StatefulWidget {
  final List<BillModel> listBills;

  const BillsListView({Key key, @required this.listBills})
      : assert(listBills != null),
        super(key: key);

  @override
  _BillsListViewState createState() => _BillsListViewState();
}

class _BillsListViewState extends State<BillsListView> {
  RefreshController _refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      header: defaultTargetPlatform == TargetPlatform.iOS
          ? WaterDropHeader()
          : WaterDropMaterialHeader(),
      controller: _refreshController,
      onRefresh: () {
        BlocProvider.of<BillBloc>(context).dispatch(FetchAllBill());
      },
      child: ListView.builder(
        itemCount: widget.listBills.length,
        itemBuilder: (context, index) {
          return BlocProvider(
            child: BillItem(
              bill: widget.listBills[index],
            ), bloc: BlocProvider.of<BillBloc>(context),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}
