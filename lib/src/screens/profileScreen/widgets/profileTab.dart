import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.contact_mail),
          title: Text('Hieren Lee'),
        ),
        ListTile(
          leading: Icon(Icons.mail),
          title: Text('hienlh1298@gmail.com'),
        ),
        ListTile(
          leading: Icon(Icons.calendar_today),
          title: Text('1/2/1998'),
        ),
      ],
    );
  }
}