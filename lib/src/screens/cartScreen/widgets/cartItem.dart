import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CartItem extends StatefulWidget {
  final bool canChangeQuantity;

  const CartItem({Key key, this.canChangeQuantity = true}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CartItemState();
}

class CartItemState extends State<CartItem> {
  int _count = 1;

  bool get canChangeQuantity => widget.canChangeQuantity;

  void _increase() {
    setState(() {
      _count = _count + 1;
    });
  }

  void _decrease() {
    setState(() {
      _count = _count == 1 ? _count : _count - 1;
    });
  }

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
              'https://znews-photo.zadn.vn/w660/Uploaded/jaroin/2016_08_25/qnn.jpg',
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
                  'Gỏi cuốn ngon nhất Sài Gòn',
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
              Text('1.000.000 VNĐ'),
            ],
          ),
          Column(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: primaryColor,
                  ),
                  onPressed: canChangeQuantity ? _increase : null,
                ),
              ),
              SizedBox(
                  height: 30,
                  child: Row(
                    children: <Widget>[
                      Text(_count.toString()),
                    ],
                  )),
              SizedBox(
                height: 25,
                width: 60,
                child: FlatButton(
                  color: Colors.white,
                  splashColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryColor,
                  ),
                  onPressed: canChangeQuantity ? _decrease : null,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
