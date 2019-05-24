import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:restaurant_management_mobile/src/blocs/billBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/billItemBloc/state.dart';
import 'package:restaurant_management_mobile/src/enums/billStatus.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';
import 'package:restaurant_management_mobile/src/screens/billDetailScreen/billDetailScreen.dart';

class BillItem extends StatefulWidget {
  final BillModel bill;

  const BillItem({Key key, @required this.bill})
      : assert(bill != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() => BillItemState();
}

class BillItemState extends State<BillItem> {
  BillModel get bill => widget.bill;
  final BillItemBloc _billItemBloc = BillItemBloc();

  bool isUpdating = false;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return BlocListener(
      bloc: _billItemBloc,
      listener: (BuildContext context, state) {
        if (state is BillItemUpdatingStatus) {
          setState(() {
            isUpdating = true;
          });
          return;
        } else if (state is BillItemUpdateStatusFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Bạn không thể sửa trạng thái hoá đơn này.'),
            backgroundColor: Colors.red,
          ));
        }
        setState(() {
          isUpdating = false;
        });
      },
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BillDetailScreen(
                        bill: bill,
                      )));
        },
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: IntrinsicWidth(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(0),
                      color: Color.fromRGBO(88, 37, 176, 0.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          'Mã: ${bill.billId}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(0),
                      color: Colors.teal,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          _mapBillStatus(bill.status),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Số món',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(bill.billDetails.length.toString())
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 1,
                      child: Container(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Bàn',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text('Đang phát triển!')
                        ],
                      ),
                    ),
                  ],
                ),
                _buildButton(context, bill.status)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, BillStatus status) {
    final BillBloc _billBloc = BlocProvider.of<BillBloc>(context);

    if (status == BillStatus.created) {
      return _buildButtonWidget('Xác nhận đã thanh toán', increaseWidthBy: 90,
          onPressed: () {
        _billItemBloc.dispatch(PayBill(bill, _billBloc));
      });
    } else if (status == BillStatus.paid)
      return _buildButtonWidget('Chuẩn bị món', increaseWidthBy: 50,
          onPressed: () {
        _billItemBloc.dispatch(PrepareBill(bill, _billBloc));
      });
    else if (status == BillStatus.preparing)
      return _buildButtonWidget('Chuẩn bị món xong', onPressed: () {
        _billItemBloc.dispatch(FinishPrepareBill(bill, _billBloc));
      });
    else if (status == BillStatus.prepareDone)
      return _buildButtonWidget('Giao tới bàn', increaseWidthBy: 50,
          onPressed: () {
        _billItemBloc.dispatch(DeliveryBill(bill, _billBloc));
      });
    else if (status == BillStatus.delivering || status == BillStatus.shipping)
      return _buildButtonWidget('Giao đến bàn hoàn tất', increaseWidthBy: 80,
          onPressed: () {
        _billItemBloc.dispatch(FinishDeliveryBill(bill, _billBloc));
      });
    return SizedBox(
      height: 20,
    );
  }

  Widget _buildButtonWidget(String text,
      {VoidCallback onPressed, double increaseWidthBy = 60}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        GradientButton(
          child: Text(text),
          increaseWidthBy: increaseWidthBy,
          callback: onPressed,
          gradient: LinearGradient(
            colors: <Color>[
              !isUpdating
                  ? Color.fromRGBO(88, 150, 176, 1)
                  : Color.fromRGBO(0, 0, 0, 0.3),
              !isUpdating
                  ? Color.fromRGBO(88, 39, 176, 1)
                  : Color.fromRGBO(0, 0, 0, 0.3),
            ],
            stops: [0.1, 1.0],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),
      ],
    );
  }

  String _mapBillStatus(BillStatus status) {
    if (status == BillStatus.paid) {
      return 'Đã thanh toán';
    } else if (status == BillStatus.created)
      return 'Chưa thanh toán';
    else if (status == BillStatus.preparing)
      return 'Đang chuẩn bị';
    else if (status == BillStatus.prepareDone)
      return 'Chuẩn bị xong';
    else if (status == BillStatus.delivering || status == BillStatus.shipping)
      return 'Đang mang tới bàn';
    return 'Đã hoàn thành';
  }
}
