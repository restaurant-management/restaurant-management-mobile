import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/screens/dishesTodayScreen/index.dart';
import 'loginTextInput.dart';

import 'loginButton.dart';

class SignUpForm extends StatefulWidget {
  final GestureTapCallback onTap;

  SignUpForm({this.onTap});

  @override
  State<StatefulWidget> createState() {
    return SignUpFormState(onTap: onTap);
  }
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  GestureTapCallback onTap;

  SignUpFormState({this.onTap});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: new BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: new LinearGradient(
                  colors: <Color>[
                    const Color.fromRGBO(88, 39, 176, 0.5),
                    const Color.fromRGBO(156, 39, 176, 0.6),
                    const Color.fromRGBO(0, 0, 0, 0.7),
                  ],
                  stops: [0.1, 0.5, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/logo.png',
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Divider(color: Colors.transparent),
                    LoginTextInput(
                      hint: 'Email / Tên đăng nhập',
                      icon: Icons.person_outline,
                      obscure: false,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Vui lòng nhập thông tin vào trường này!';
                      },
                    ),
                    Divider(color: Colors.transparent),
                    LoginTextInput(
                      hint: 'Mật khẩu',
                      icon: Icons.lock_outline,
                      obscure: true,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Vui lòng nhập thông tin vào trường này!';
                      },
                    ),
                    Divider(color: Colors.transparent),
                    LoginTextInput(
                      hint: 'Nhập lại mật khẩu',
                      icon: Icons.lock_outline,
                      obscure: true,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Vui lòng nhập thông tin vào trường này!';
                      },
                    ),
                    Divider(color: Colors.transparent),
                    LoginButton(
                      text: "Đăng ký",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DishesTodayScreen()));
                        }
                      },
                    ),
                    Divider(
                      color: Colors.transparent,
                    ),
                    InkWell(
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: onTap,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
