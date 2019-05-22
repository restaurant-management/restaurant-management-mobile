import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:restaurant_management_mobile/src/models/billModel.dart';
import 'package:restaurant_management_mobile/src/screens/billDetailScreen/billDetailScreen.dart';

class BillItem extends StatefulWidget {
  final BillModel bill;

  const BillItem({Key key, @required this.bill}) : assert(bill != null), super(key: key);

  @override
  State<StatefulWidget> createState() => BillItemState();
}

class BillItemState extends State<BillItem> {
  BillModel get bill => widget.bill;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BillDetailScreen(bill: bill,)));
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
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        bill.status.toString(),
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GradientButton(
                    child: Text('Chuẩn bị xong'),
                    increaseWidthBy: 50,
                    callback: () {},
                    gradient: LinearGradient(
                      colors: <Color>[
                        const Color.fromRGBO(88, 150, 176, 1),
                        const Color.fromRGBO(88, 39, 176, 1),
                      ],
                      stops: [0.1, 1.0],
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
