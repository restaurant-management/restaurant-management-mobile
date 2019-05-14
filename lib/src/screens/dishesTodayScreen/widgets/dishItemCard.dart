import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_management_mobile/src/screens/dishDetailScreen/index.dart';

class DishItemCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String discount;
  final String currentCost;
  final String defaultCost;

  const DishItemCard(
      {Key key,
      this.imageUrl,
      this.name,
      this.discount = '',
      this.currentCost,
      this.defaultCost})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size contextSize = MediaQuery.of(context).size;
    final Color primaryColor = Theme.of(context).primaryColor;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DishDetailScreen()));
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        elevation: 4.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    topLeft: Radius.circular(20)),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: contextSize.width / 2.2,
                  height: contextSize.width / 2,
                ),
              ),
              _buildDiscount(discount: discount)
            ]),
            Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  SizedBox(
                    width: contextSize.width / 2.4,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    width: contextSize.width / 2.4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Text(
                          '1.000.000',
                          style: Theme.of(context).textTheme.body1,
                        ),
                        Text(
                          '1.250.000',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 1,
              width: contextSize.width / 2.2,
              child: Container(
                color: primaryColor,
              ),
            ),
            SizedBox(
              width: contextSize.width / 2.2,
              height: 40,
              child: FlatButton(
                color: Colors.white,
                splashColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.shopping_cart, color: primaryColor,),
                    SizedBox(width: 8,),
                    Text(
                      'Thêm vào hoá đơn',
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildDiscount({String discount = ''}) {
    return discount != ''
        ? Positioned(
            right: 5,
            top: 5,
            width: 40,
            height: 40,
            child: Stack(children: <Widget>[
              Image.asset(
                'assets/icons/sticker.png',
                fit: BoxFit.cover,
              ),
              Center(
                child: Text(
                  discount,
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          )
        : SizedBox();
  }
}
