import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/models/billDetailModel.dart';

class DishItem extends StatelessWidget {
  final BillDetailModel billDetailModel;

  const DishItem({Key key, @required this.billDetailModel})
      : assert(billDetailModel != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20), topLeft: Radius.circular(20)),
            child: Image.network(
              billDetailModel.dish.images[0],
              fit: BoxFit.cover,
              width: 80,
              height: 80,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: Text(
                  billDetailModel.dish.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: primaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text('${billDetailModel.price.toString()} VNĐ'),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 80,
                child: Center(
                    child: Text(
                  'Số lượng',
                  style: TextStyle(color: primaryColor),
                )),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(billDetailModel.quantity.toString()),
                    ],
                  )),
            ],
          )
        ],
      ),
    );
  }
}
