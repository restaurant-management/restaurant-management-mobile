import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dishItemCard.dart';

class DishesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.background,
        child: SingleChildScrollView(
          child: Column(
            children: _buildRow(),
          ),
        ));
  }

  List<Widget> _buildRow() {
    List<Widget> rows = [];
    for (int i = 1; i < 10; i++) {
      rows.add(SizedBox(
        height: 10,
      ));
      rows.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DishItemCard(
            imageUrl:
                'https://znews-photo.zadn.vn/w660/Uploaded/jaroin/2016_08_25/qnn.jpg',
            name: 'Gởi cuốn',
          ),
          DishItemCard(
            imageUrl:
                'https://www.webtretho.com/contentreview/wp-content/uploads/sites/53/2018/04/cach-lam-mon-ngon-dai-tiec-cuoi-tuan-nhanh-chong-va-cuc-de-dang-01.jpg',
            name: 'Gà hấp chanh',
            discount: '-20%',
          ),
        ],
      ));
    }
    rows.add(SizedBox(
      height: 60,
    ));
    return rows;
  }
}
