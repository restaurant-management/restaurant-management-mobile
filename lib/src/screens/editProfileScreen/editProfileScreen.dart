import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:intl/intl.dart';

import '../../widgets/AppBars/backAppBar.dart';
import '../../widgets/drawerScaffold.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditProfileState();
  }
}

class EditProfileState extends State<EditProfileScreen> {
  String _name;
  String _email;
  DateTime _birthday;
  final _birthdayTextFieldController = new TextEditingController();

  @override
  void initState() {
    _birthday = DateTime.now();
    _name = 'Hieren Lee';
    _email = 'hienlh1298@gmail.com';
    _birthdayTextFieldController.text =
        DateFormat('dd/MM/yyyy').format(_birthday);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DrawerScaffold(
      appBar: BackAppBar(
        showShoppingCart: false,
      ),
      body: Form(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextFormField(
                        initialValue: _name,
                        style: TextStyle(color: primaryColor),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.contact_mail,
                            color: primaryColor,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: 'Họ và tên',
                          labelStyle: TextStyle(color: primaryColor),
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            _name = value;
                          });
                        },
                      ),
                      TextFormField(
                        initialValue: _email,
                        style: TextStyle(color: primaryColor),
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.mail,
                              color: primaryColor,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                            labelText: 'Email',
                            labelStyle: TextStyle(color: primaryColor)),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: AbsorbPointer(
                          child: TextFormField(
                            controller: _birthdayTextFieldController,
                            enabled: false,
                            style: TextStyle(color: primaryColor),
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: primaryColor,
                                ),
                                contentPadding:
                                    EdgeInsets.fromLTRB(20, 15, 20, 15),
                                labelText: 'Ngày sinh',
                                labelStyle: TextStyle(color: primaryColor)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      GradientButton(
                        increaseWidthBy: 50,
                        child: Text('Lưu'),
                        gradient: LinearGradient(
                          colors: <Color>[
                            const Color.fromRGBO(88, 39, 176, 1),
                            const Color.fromRGBO(0, 39, 176, 1),
                          ],
                          stops: [0.1, 1.0],
                          begin: Alignment.bottomRight,
                          end: Alignment.topLeft,
                        ),
                        callback: () {},
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: _birthday,
        firstDate: DateTime(1900),
        lastDate: DateTime(2020));
    if (picked != null && picked != _birthday) {
      setState(() {
        _birthday = picked;
      });
      _birthdayTextFieldController.text =
          DateFormat('dd/MM/yyyy').format(_birthday);
    }
  }
}
