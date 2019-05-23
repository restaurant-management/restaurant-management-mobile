import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/dailyDishBloc/bloc.dart';
import '../../../blocs/dailyDishBloc/event.dart';
import '../../../blocs/dailyDishBloc/state.dart';
import '../../../models/dailyDish.dart';
import '../../../widgets/loadingIndicator.dart';
import 'dishItemCard.dart';

class DishesList extends StatefulWidget {
  @override
  _DishesListState createState() => _DishesListState();
}

class _DishesListState extends State<DishesList> {
  final DailyDishBloc _dailyDishBloc = DailyDishBloc();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _dailyDishBloc,
      builder: (BuildContext context, state) {
        if (state is DailyDishInitialized) {
          _dailyDishBloc.dispatch(FetchDailyDish());
          return LoadingIndicator();
        }
        if (state is DailyDishFetching) return LoadingIndicator();
        if (state is DailyDishFetched) {
          if (state.listDailyDish.length == 0) {
            return Container(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Text('Không có món nào cả!'),
                      FlatButton(
                        child: Text('Tải lại'),
                        onPressed: () {
                          _dailyDishBloc.dispatch(FetchDailyDish());
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }
          return Container(
              color: Theme
                  .of(context)
                  .colorScheme
                  .background,
              child: SingleChildScrollView(
                child: Column(
                  children: _buildRow(state.listDailyDish),
                ),
              ));
        }
        if (state is DailyDishFetchFailure) {
          return Container(
            child: Center(
              child: Text(state.error),
            ),
          );
        }
      },
    );
  }

  List<Widget> _buildRow(List<DailyDish> listDailyDish) {
    List<Widget> rows = [];
    for (int i = 0; i < listDailyDish.length; i += 2) {
      rows.add(SizedBox(
        height: 10,
      ));
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DishItemCard(
            dailyDish: listDailyDish[i],
          ),
          i + 1 < listDailyDish.length
              ? DishItemCard(
            dailyDish: listDailyDish[i + 1],
          )
              : Container(
            width: MediaQuery
                .of(context)
                .size
                .width / 2.2,
          ),
        ],
      ));
    }
    rows.add(SizedBox(
      height: 60,
    ));
    return rows;
  }
}
