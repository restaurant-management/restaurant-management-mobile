import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/cartBloc/state.dart';

import 'summaryBill.dart';

class CartFooter extends StatefulWidget {
  final double height;
  final bool hasCreateButton;

  const CartFooter(
      {Key key, @required this.height, this.hasCreateButton = true})
      : super(key: key);

  @override
  _CartFooterState createState() => _CartFooterState();
}

class _CartFooterState extends State<CartFooter> {
  bool _isCreating = false;
  CartBloc _cartBloc = CartBloc();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cartBloc,
      listener: (BuildContext context, CartBlocState state) {
        if (state is CartBlocCreatingBill) {
          setState(() {
            _isCreating = true;
          });
        }
        if (state is CartBlocCreatedBill || state is CartBlocCreateBillFailure)
          setState(() {
            _isCreating = false;
          });
      },
      child: Container(
        height: widget.height,
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SummaryBill(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GradientButton(
                  increaseWidthBy: 100,
                  increaseHeightBy: MediaQuery.of(context).size.height * 0.01,
                  child: Text('Tạo hoá đơn'),
                  gradient: LinearGradient(
                    colors: <Color>[
                      !_isCreating
                          ? const Color.fromRGBO(88, 39, 176, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                      !_isCreating
                          ? const Color.fromRGBO(0, 39, 176, 1)
                          : const Color.fromRGBO(0, 0, 0, 0.5),
                    ],
                    stops: [0.1, 1.0],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  callback: () {
                    if (!_isCreating) _cartBloc.dispatch(CreateBillFromCart());
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
