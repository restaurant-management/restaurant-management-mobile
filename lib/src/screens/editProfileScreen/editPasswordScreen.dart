import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:restaurant_management_mobile/src/widgets/AppBars/backAppBar.dart';
import 'package:restaurant_management_mobile/src/widgets/drawerScaffold.dart';

class EditPasswordScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditPasswordState();
  }
}

class EditPasswordState extends State<EditPasswordScreen> {
  String _oldPassword;
  String _newPassword;
  String _confirmPassword;

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
                        obscureText: true,
                        style: TextStyle(color: primaryColor),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.vpn_key,
                            color: primaryColor,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: 'Mật khẩu cũ',
                          labelStyle: TextStyle(color: primaryColor),
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            _oldPassword = value;
                          });
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: primaryColor),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: primaryColor,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: 'Mật khẩu mới',
                          labelStyle: TextStyle(color: primaryColor),
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            _newPassword = value;
                          });
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        style: TextStyle(color: primaryColor),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.lock,
                            color: primaryColor,
                          ),
                          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          labelText: 'Nhập lại mật khẩu',
                          labelStyle: TextStyle(color: primaryColor),
                        ),
                        onFieldSubmitted: (value) {
                          setState(() {
                            _confirmPassword = value;
                          });
                        },
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
}
