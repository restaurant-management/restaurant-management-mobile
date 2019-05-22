import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/event.dart';

import '../../../blocs/billBloc/bloc.dart';
import '../../../blocs/billBloc/state.dart';
import '../../../widgets/loadingIndicator.dart';
import 'billItem.dart';

class BillsListView extends StatelessWidget {
  final BillBloc _billBloc = BillBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      builder: (BuildContext context, state) {
        if (state is BillBlocFetched)
          return ListView.builder(
            itemCount: state.listBill.length,
            itemBuilder: (context, index) {
              return BillItem(bill: state.listBill[index],);
            },
          );
        if (state is BillBlocInitialize) {
          _billBloc.dispatch(FetchAllBill());
          return LoadingIndicator();
        }
        if (state is BillBlocFetching) return LoadingIndicator();
        if (state is BillBlocFetchFailure)
          return Container(
            child: Center(
              child: Text(
                state.error,
                style: TextStyle(color: Colors.red),
              ),
            ),
          );
      },
      bloc: _billBloc,
    );
  }
}
