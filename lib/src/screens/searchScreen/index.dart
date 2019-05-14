import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        title: TextField(
          style: TextStyle(color: primaryColor),
          autofocus: true,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.search,
              color: primaryColor,
            ),
            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            hintText: 'Nhập tên món ăn ...',
            hintStyle: TextStyle(color: Color.fromRGBO(88, 37, 176, 0.8)),
          ),
        ),
      ),
    );
  }
}
