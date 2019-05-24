import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/state.dart';
import 'package:restaurant_management_mobile/src/widgets/errorIndicator.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';

import '../../widgets/AppBars/backAppBar.dart';
import 'widgets/billsListView.dart';

class BillsScreen extends StatelessWidget {
  final bool isMyBill;

  BillsScreen({Key key, this.isMyBill = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BillBloc _billBloc = BillBloc(isMyBill: isMyBill);
    return Scaffold(
      appBar: BackAppBar(showShoppingCart: false),
      body: Container(
        color: Theme.of(context).colorScheme.background,
        child: BlocBuilder(
          bloc: _billBloc,
          builder: (BuildContext context, state) {
            if (state is BillBlocFetched)
              return BlocProvider(
                child: BillsListView(
                  listBills: state.listBills,
                ),
                bloc: _billBloc,
              );
            if (state is BillBlocInitialize) {
              _billBloc.dispatch(FetchAllBill());
              return LoadingIndicator();
            }
            if (state is BillBlocFetching) return LoadingIndicator();
            if (state is BillBlocFetchFailure)
              return ErrorIndicator(
                message: 'Tải danh sách hoá đơn thất bại!',
                reloadOnPressed: () {
                  _billBloc.dispatch(FetchAllBill());
                },
              );
          },
        ),
      ),
    );
  }
}
