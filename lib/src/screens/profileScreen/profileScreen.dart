// https://www.developerlibs.com/2018/08/flutter-collapsing-toolbar-layout.html
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/profileScreenBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/profileScreenBloc/state.dart';

import '../../utils/outlineText.dart';
import '../dishesTodayScreen/widgets/dishesList.dart';
import '../editProfileScreen/editProfileScreen.dart';
import 'widgets/profileTab.dart';

class ProfileScreen extends StatefulWidget {
  final ProfileScreenBloc profileScreenBloc;

  const ProfileScreen({Key key, this.profileScreenBloc})
      : assert(profileScreenBloc != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ProfileScreenState();
  }
}

class ProfileScreenState extends State<ProfileScreen> {
  ScrollController scrollController;

  ProfileScreenBloc get profileScreenBloc => widget.profileScreenBloc;

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
                      image: AssetImage('assets/images/login-background.jpg'),
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
                  BlocProvider(
                    child: ProfileTab(),
                    bloc: profileScreenBloc,
                  ),
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
      child: BlocBuilder(
        bloc: profileScreenBloc,
        builder: (BuildContext context, state) {
          String avatarUrl;
          if (state is ProfileScreenFetched ||
              state is ProfileScreenInitialize) {
            avatarUrl = state.currentUser.avatar;
          }
          return Hero(
            tag: "avatarHero",
            child: ClipOval(
              child: avatarUrl != null
                  ? FadeInImage.assetNetwork(
                      placeholder: 'assets/images/default-avatar.jpg',
                      fit: BoxFit.fill,
                      image: avatarUrl,
                    )
                  : Image.asset(
                      'assets/images/default-avatar.jpg',
                      fit: BoxFit.fill,
                    ),
            ),
          );
        },
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
