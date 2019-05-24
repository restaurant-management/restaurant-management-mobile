import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/state.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';
import '../../widgets/AppBars/mainAppBar.dart';
import '../../widgets/cartButton/secondaryCartButton.dart';
import '../../widgets/drawerScaffold.dart';

import 'package:restaurant_management_mobile/src/widgets/dishList/dishesList.dart';

class DishesTodayScreen extends StatelessWidget {
  final DailyDishBloc _dailyDishBloc = DailyDishBloc();

  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
        BlocBuilder(
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
              return DishesList(
                listDailyDish: state.listDailyDish,
              );
            }
            if (state is DailyDishFetchFailure) {
              return Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: <Widget>[
                        Text(state.error.split(':')[1]),
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
          },
        ),
        Align(
          heightFactor: 60,
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: new BoxDecoration(
                gradient: new LinearGradient(
              colors: <Color>[
                const Color.fromRGBO(88, 39, 176, 0.7),
                const Color.fromRGBO(88, 39, 176, 0.3),
                const Color.fromRGBO(88, 39, 176, 0.0),
              ],
              stops: [0.1, 0.7, 1.0],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
            height: 60.0,
          ),
        )
      ]),
    );
  }
}
