import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_management_mobile/src/screens/dishesTodayScreen/index.dart';
import 'package:restaurant_management_mobile/src/widgets/loadingButton.dart';
import 'loginButton.dart';
import 'loginLogo.dart';
import 'loginTextInput.dart';

class LoginForm extends StatefulWidget {
  final GestureTapCallback onTap;

  LoginForm({this.onTap});

  @override
  State<StatefulWidget> createState() {
    return LoginFormState(onTap: onTap);
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  GestureTapCallback onTap;

  LoginFormState({this.onTap});

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
                    LoginLogo(),
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
                    LoginButton(
                      text: "Đăng nhập",
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Processing Data')));
                          Navigator.pushReplacement(
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
                        'Đăng ký',
                        style: TextStyle(
                            color: Colors.white,
                            decoration: TextDecoration.underline),
                      ),
                      onTap: onTap,
                    ),
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
