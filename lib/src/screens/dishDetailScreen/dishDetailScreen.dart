import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_images_slider/flutter_images_slider.dart';

import '../../models/dailyDish.dart';
import '../../models/dishModal.dart';
import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';
import 'widgets/addCartButton.dart';
import 'widgets/expanedDetail.dart';

class DishDetailScreen extends StatefulWidget {
  final DishModal dishModal;
  final DailyDish dailyDish;

  const DishDetailScreen({Key key, this.dishModal, this.dailyDish})
      : assert((dishModal == null || dailyDish == null) &&
            (dishModal != null || dailyDish != null)),
        super(key: key);

  @override
  _DishDetailScreenState createState() => _DishDetailScreenState();
}

class _DishDetailScreenState extends State<DishDetailScreen> {
  int _discountPrice;
  DishModal _dish;

  @override
  void initState() {
    if (widget.dailyDish != null) {
      _dish = widget.dailyDish.dish;
      _discountPrice = widget.dailyDish.price;
    } else {
      _dish = widget.dishModal;
      _discountPrice = 0;
    }
    super.initState();
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return DrawerScaffold(
      appBar: BackAppBar(),
      bottomNavigationBar: AddCartButton(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ImagesSlider(
              items: map<Widget>(_dish.images, (index, i) {
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(i), fit: BoxFit.cover)),
                );
              }),
              autoPlay: true,
              viewportFraction: 1.0,
              aspectRatio: 1.5,
              distortion: false,
              align: IndicatorAlign.bottom,
              indicatorWidth: 5,
              indicatorColor: Theme.of(context).colorScheme.background,
              indicatorBackColor: primaryColor,
              updateCallback: (index) {},
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: Text(
                      _dish.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      color: Colors.black,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: <Widget>[
                  _discountPrice > 0
                      ? Text(
                          '${_dish.defaultPrice} VNĐ',
                          style: TextStyle(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        )
                      : Container(),
                  _discountPrice > 0
                      ? SizedBox(
                          width: 20,
                        )
                      : Container(),
                  Text(
                    '${_discountPrice > 0 ? _discountPrice : _dish.defaultPrice} VNĐ',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 2,
              color: Colors.grey,
            ),
            ExpandedDetail(
              title: 'Chi tiết',
              child: Text(
                _dish.description,
                style: TextStyle(color: Colors.black),
              ),
              expand: true,
            ),
            SizedBox(
              height: 10,
            ),
            Divider(
              height: 2,
              color: Colors.grey,
            ),
            ExpandedDetail(
              title: 'Nhận xét',
              child: Text(
                'Chức năng đang phát triển',
                style: TextStyle(color: Colors.black),
              ),
              expand: false,
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
