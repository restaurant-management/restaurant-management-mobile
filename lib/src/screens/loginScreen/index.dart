import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'widgets/signUpForm.dart';

import 'widgets/imageBackground.dart';
import 'widgets/loginForm.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final PageController controller = PageController();
  var currentPageValue = 0.0;

  @override
  Widget build(BuildContext context) {
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    return Scaffold(
      body: Stack(
        children: <Widget>[
          ImageBackground(),
          PageView.builder(
            controller: controller,
            itemBuilder: (context, position) {
              if (position == 0) {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateY(currentPageValue - position)
                      ..rotateZ(currentPageValue - position),
                    child: LoginForm(onTap: () {
                      controller.animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    }));
              } else {
                return Transform(
                    transform: Matrix4.identity()
                      ..rotateY(currentPageValue - position)
                      ..rotateZ(currentPageValue - position),
                    child: SignUpForm(onTap: () {
                      controller.animateToPage(0,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.decelerate);
                    }));
              }
            },
            itemCount: 2,
          ),
        ],
      ),
    );
  }
}
