import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/state.dart';

class SecondaryCartButton extends StatefulWidget {
  final Color color;

  const SecondaryCartButton({Key key, this.color}) : super(key: key);

  @override
  _SecondaryCartButtonState createState() => _SecondaryCartButtonState();
}

class _SecondaryCartButtonState extends State<SecondaryCartButton> {
  int _count = 0;

  final CartBloc _cartBloc = CartBloc();

  @override
  Widget build(BuildContext context) {
    _cartBloc.state.listen((state) {
      if (state is CartBlocSaved || state is CartBlocFetched) {
        setState(() {
          _count = _cartBloc.currentCart.listDishes.length;
        });

      }
    });
    return InkWell(
      onTap: () {
        Scaffold.of(context).openDrawer();
      },
      child: Stack(children: <Widget>[
        FloatingActionButton(
          elevation: 10,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            Icons.shopping_cart,
            color: widget.color != null ? widget.color : Colors.white,
          ),
        ),
        Positioned(
          top: 7,
          right: 7,
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Icon(
                Icons.brightness_1,
                color: Colors.red,
                size: 20,
              ),
              Text(
                _count.toString(),
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        )
      ]),
    );
  }
}
