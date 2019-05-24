import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/event.dart';
import 'package:restaurant_management_mobile/src/blocs/currentUserBloc/state.dart';
import 'package:restaurant_management_mobile/src/enums/permission.dart';
import 'package:restaurant_management_mobile/src/models/userModel.dart';
import 'package:restaurant_management_mobile/src/widgets/errorIndicator.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingIndicator.dart';

import '../../blocs/authenticationBloc/bloc.dart';
import '../../blocs/authenticationBloc/event.dart';
import '../../blocs/authenticationBloc/state.dart';
import '../billsScreen/billScreen.dart';
import '../editProfileScreen/editPasswordScreen.dart';
import '../editProfileScreen/editProfileScreen.dart';
import '../loginScreen/loginScreen.dart';
import 'profileScreen.dart';

class ProfileDrawer extends StatefulWidget {
  final AuthenticationBloc authenticationBloc;

  const ProfileDrawer({Key key, @required this.authenticationBloc})
      : assert(authenticationBloc != null),
        super(key: key);

  @override
  _ProfileDrawerState createState() => _ProfileDrawerState();
}

class _ProfileDrawerState extends State<ProfileDrawer> {
  CurrentUserBloc _currentUserBloc = CurrentUserBloc();

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: widget.authenticationBloc,
      listener: (BuildContext context, state) {
        if (state is AuthenticationUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (BuildContext context) => LoginScreen(
                    authenticationBloc: widget.authenticationBloc,
                  ),
            ),
          );
        }
      },
      child: Drawer(
        child: BlocBuilder(
          bloc: _currentUserBloc,
          builder: (BuildContext context, state) {
            if (state is CurrentUserProfileFetched)
              return _buildContent(state.user, _currentUserBloc.allPermission);
            if (state is CurrentUserProfileFetchFailure) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ErrorIndicator(
                    message: 'Tải thông tin thất bại!',
                    reloadOnPressed: () {
                      _currentUserBloc.dispatch(FetchCurrentUserProfile());
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      widget.authenticationBloc.dispatch(LoggedOut());
                    },
                    child: Text('Đăng xuất'),
                  )
                ],
              );
            }
            return LoadingIndicator();
          },
        ),
      ),
    );
  }

  Widget _buildContent(UserModel user, List<Permission> allPermissions) {
    return ListView(
      children: <Widget>[
        UserAccountsDrawerHeader(
          accountEmail: Text(user.email),
          accountName: Text(user.fullName ?? user.username),
          currentAccountPicture: GestureDetector(
            onTap: () {},
            child: Container(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(
                              user: user,
                            ),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "avatarHero",
                    child: ClipOval(
                      child: user.avatar != null
                          ? FadeInImage.assetNetwork(
                              placeholder: 'assets/images/default-avatar.jpg',
                              fit: BoxFit.cover,
                              image: user.avatar,
                            )
                          : Image.asset(
                              'assets/images/default-avatar.jpg',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                width: 32.0,
                height: 32.0,
                padding: const EdgeInsets.all(2.0),
                decoration: new BoxDecoration(
                  color: Theme.of(context).primaryColor, // border color
                  shape: BoxShape.circle,
                )),
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/cover.jpg'),
            ),
          ),
        ),
        haveUpdateBillStatusPermission(allPermissions)
            ? ListTile(
                leading: Icon(
                  Icons.assignment,
                  color: Colors.blue,
                ),
                title: Text(
                  'Danh sách hoá đơn',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => BillsScreen()));
                },
              )
            : Container(),
        ListTile(
          leading: Icon(
            Icons.description,
            color: Colors.pinkAccent,
          ),
          title: Text(
            'Hoá đơn của tôi',
            style: TextStyle(color: Colors.pinkAccent, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BillsScreen(
                          isMyBill: true,
                        )));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.assignment_ind,
            color: Colors.teal,
          ),
          title: Text(
            'Sửa thông tin',
            style: TextStyle(color: Colors.teal, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => EditProfileScreen()));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.lock,
            color: Colors.deepPurple,
          ),
          title: Text(
            'Đổi mật khẩu',
            style: TextStyle(color: Colors.deepPurple, fontSize: 16),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditPasswordScreen(
                          currentUser: user,
                        )));
          },
        ),
        ListTile(
          leading: Icon(
            Icons.keyboard_return,
            color: Colors.deepOrange,
          ),
          title: Text(
            'Đăng xuất',
            style: TextStyle(color: Colors.deepOrange, fontSize: 16),
          ),
          onTap: () {
            widget.authenticationBloc.dispatch(LoggedOut());
          },
        )
      ],
    );
  }

  bool haveUpdateBillStatusPermission(List<Permission> permissions) {
    return permissions.indexOf(Permission.billManagement) >= 0 ||
        permissions.indexOf(Permission.updateCompleteBillStatus) >= 0 ||
        permissions.indexOf(Permission.updateDeliveringBillStatus) >= 0 ||
        permissions.indexOf(Permission.updatePrepareDoneBillStatus) >= 0 ||
        permissions.indexOf(Permission.updatePreparingBillStatus) >= 0 ||
        permissions.indexOf(Permission.updateShippingBillStatus) >= 0 ||
        permissions.indexOf(Permission.updatePaidBillStatus) >= 0;
  }
}
