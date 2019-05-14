import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/widgets/AppBars/mainAppBar.dart';
import 'package:restaurant_management_mobile/src/widgets/cartButton/secondaryCartButton.dart';
import 'package:restaurant_management_mobile/src/widgets/drawerScaffold.dart';

import 'widgets/dishesList.dart';

class DishesTodayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DrawerScaffold(
      appBar: MainAppBar(),
      floatingActionButton: SecondaryCartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(children: <Widget>[
        DishesList(),
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
