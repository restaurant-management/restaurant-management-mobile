import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/dailyDishBloc/state.dart';
import 'package:restaurant_management_mobile/src/models/dailyDish.dart';
import 'package:restaurant_management_mobile/src/widgets/dishList/dishesList.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  String keyword;
  final DailyDishBloc _dailyDishBloc = DailyDishBloc();

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        title: TextField(
          onChanged: (value) {
            setState(() {
              keyword = value;
            });
          },
          style: TextStyle(color: primaryColor),
          autofocus: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Nhập tên món ăn ...',
            hintStyle: TextStyle(color: Color.fromRGBO(88, 37, 176, 0.8)),
          ),
        ),
      ),
      body: BlocBuilder(
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
            return _buildSearchList(state.listDailyDish);
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
    );
  }

  Widget _buildSearchList(List<DailyDish> dailyDishes) {
    List<DailyDish> searchList = [];
    if (keyword == null || keyword.isEmpty)
      searchList = dailyDishes;
    else {
      searchList = dailyDishes
          .where(
              (e) => e.dish.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    return DishesList(
      listDailyDish: searchList,
    );
  }
}
