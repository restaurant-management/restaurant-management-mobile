import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_images_slider/flutter_images_slider.dart';

import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';
import 'widgets/addCartButton.dart';
import 'widgets/expanedDetail.dart';

class DishDetailScreen extends StatelessWidget {
  final List<String> imgList = [
    'https://znews-photo.zadn.vn/w660/Uploaded/jaroin/2016_08_25/qnn.jpg',
    'https://www.webtretho.com/contentreview/wp-content/uploads/sites/53/2018/04/cach-lam-mon-ngon-dai-tiec-cuoi-tuan-nhanh-chong-va-cuc-de-dang-01.jpg',
  ];

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
              items: map<Widget>(imgList, (index, i) {
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
                      'Gà hấp chanh lá chuối các kiểu con đà điểu, hết sảy con nhà bà bảy',
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
                  Text(
                    '1.250.000 VNĐ',
                    style: TextStyle(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    '1.000.000 VNĐ',
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
                'When a user starts a conversation with your business, you may want to identify him or her as a customer who already has an account with your business. To help with this, we have created a secured protocol to link and unlink the Messenger user identity with your business user identity.',
                style: TextStyle(color: Colors.black),
              ),
              expand: false,
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
                'When a user starts a conversation with your business, you may want to identify him or her as a customer who already has an account with your business. To help with this, we have created a secured protocol to link and unlink the Messenger user identity with your business user identity.',
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
