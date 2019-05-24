import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';

import '../../../blocs/billBloc/bloc.dart';
import 'billItem.dart';

class BillsListView extends StatelessWidget {
  final List<BillModel> listBills;

  const BillsListView({Key key, @required this.listBills})
      : assert(listBills != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listBills.length,
      itemBuilder: (context, index) {
        return BlocProvider(
          child: BillItem(
            bill: listBills[index],
          ), bloc: BlocProvider.of<BillBloc>(context),
        );
      },
    );
  }
}
