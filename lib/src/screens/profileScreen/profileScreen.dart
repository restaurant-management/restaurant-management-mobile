// https://www.developerlibs.com/2018/08/flutter-collapsing-toolbar-layout.html
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/outlineText.dart';
import '../dishesTodayScreen/widgets/dishesList.dart';
import '../editProfileScreen/editProfileScreen.dart';
import 'widgets/profileTab.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: CustomScrollView(
          controller: scrollController,
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditProfileScreen()));
                  },
                ),
              ],
              expandedHeight: 300,
              floating: true,
              pinned: true,
              title: OutlineText(
                color: primaryColor,
                text: 'Hieren Lee',
              ),
              centerTitle: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: _buildAvatar(),
                background: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Sergio_Ag%C3%BCero_2018.jpg/220px-Sergio_Ag%C3%BCero_2018.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  labelColor: primaryColor,
                  unselectedLabelColor: Colors.black26,
                  tabs: [
                    Tab(
                      icon: Icon(Icons.assignment_ind),
                      text: "Thông tin",
                    ),
                    Tab(
                      icon: Icon(Icons.favorite),
                      text: "Món yêu thích",
                    ),
                  ],
                ),
              ),
              pinned: true,
            ),
            SliverFillRemaining(
              child: TabBarView(
                children: <Widget>[
                  ProfileTab(),
                  DishesList(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    Widget avatarWidget = Container(
      child: Hero(
        tag: "avatarHero",
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Sergio_Ag%C3%BCero_2018.jpg/220px-Sergio_Ag%C3%BCero_2018.jpg'),
        ),
      ),
      width: 150.0,
      height: 150.0,
      padding: const EdgeInsets.all(2.0),
      decoration: new BoxDecoration(
        color: Colors.white, // border color
        shape: BoxShape.circle,
      ),
    );

    double scale = 1;
    if (scrollController.hasClients) {
      if (scrollController.offset != 0)
        scale = (150 - scrollController.offset) / 150;
      if (scale < 0) {
        scale = 0;
      }
    } else {
      scale = 1;
    }

    return new Transform(
      transform: new Matrix4.identity()..scale(scale, scale),
      alignment: Alignment.center,
      child: avatarWidget,
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    scrollController = new ScrollController();
    scrollController.addListener(() => setState(() {}));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
