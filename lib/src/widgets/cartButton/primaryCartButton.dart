import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/state.dart';

class PrimaryCartButton extends StatefulWidget {
  final Color color;

  const PrimaryCartButton({Key key, this.color}) : super(key: key);

  @override
  _PrimaryCartButtonState createState() => _PrimaryCartButtonState();
}

class _PrimaryCartButtonState extends State<PrimaryCartButton> {
  int _count = 0;

  final CartBloc _cartBloc = CartBloc();

  @override
  void initState() {
    _count = _cartBloc.currentCart.listDishes.length;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cartBloc,
      listener: (BuildContext context, state) {
        if (state is CartBlocSaved ||
            state is CartBlocFetched ||
            state is CartBlocCreatedBill)
          setState(() {
            _count = _cartBloc.currentCart.listDishes.length;
          });
      },
      child: InkWell(
        onTap: () {
          Scaffold.of(context).openDrawer();
        },
        child: Stack(children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: widget.color != null
                  ? widget.color
                  : Theme.of(context).primaryColor,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
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
      ),
    );
  }
}
