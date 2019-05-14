import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../editProfileScreen/editPasswordScreen.dart';
import '../editProfileScreen/index.dart';
import '../billsScreen/index.dart';
import 'index.dart';

class ProfileDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text('hienlh1298@gmail.com'),
            accountName: Text('Hieren Lee'),
            currentAccountPicture: GestureDetector(
              onTap: () {},
              child: Container(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: Hero(
                      tag: "avatarHero",
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f2/Sergio_Ag%C3%BCero_2018.jpg/220px-Sergio_Ag%C3%BCero_2018.jpg'),
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
                image: NetworkImage(
                    'https://images.unsplash.com/photo-1557502706-5a0e03129173?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=709&q=80'),
              ),
            ),
          ),
          ListTile(
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditPasswordScreen()));
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
          )
        ],
      ),
    );
  }
}
