import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoadingButton extends StatefulWidget {
  final VoidCallback onCompleted;
  final Widget child;
  final double width;
  final double height;
  final Color color;
  final double loadingIconSize;
  final double widthTurnOnIcon;

  const LoadingButton(
      {Key key,
      this.onCompleted,
      this.child,
      this.width,
      this.height,
      this.color,
      this.loadingIconSize,
      this.widthTurnOnIcon})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoadingButtonState(onCompleted, child, width, height, color,
        loadingIconSize, widthTurnOnIcon);
  }
}

class LoadingButtonState extends State<LoadingButton>
    with SingleTickerProviderStateMixin {
  final VoidCallback onCompleted;
  final Widget title;
  final double width;
  final double height;
  final Color color;
  final double loadingIconSize;
  final double widthTurnOnIcon;

  AnimationController _buttonController;
  Animation _buttonSqueezeAnimation;

  LoadingButtonState(this.onCompleted, this.title, this.width, this.height,
      this.color, this.loadingIconSize, this.widthTurnOnIcon);

  @override
  void initState() {
    super.initState();
    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 3000), vsync: this);
    _buttonController.addStatusListener((state) {
      if (state == AnimationStatus.completed && onCompleted != null) {
        onCompleted();
      }
    });
    _buttonSqueezeAnimation = new Tween(
      begin: width != null ? width : 320.0,
      end: 70.0,
    ).animate(
      new CurvedAnimation(
        parent: _buttonController,
        curve: new Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _buttonController.dispose();
    super.dispose();
  }

  Future<Null> _playAnimation() async {
    try {
      await _buttonController.forward();
      await _buttonController.reverse();
    } on TickerCanceled {}
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: _buildAnimation,
      animation: _buttonController,
    );
  }

  Widget _buildAnimation(BuildContext context, Widget child) {
    return Material(
        elevation: 5.0,
        borderRadius: BorderRadius.circular(30.0),
        color: color != null ? color : Theme.of(context).primaryColor,
        child: SizedBox(
          width: _buttonSqueezeAnimation.value,
          height: height != null ? height : 60.0,
          child: MaterialButton(
              padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
              onPressed: () {
                _playAnimation();
              },
              child: _buttonSqueezeAnimation.value >
                      (widthTurnOnIcon != null ? widthTurnOnIcon : 75.0)
                  ? title != null ? title : Container()
                  : SizedBox(
                      height: loadingIconSize != null ? loadingIconSize : 30,
                      width: loadingIconSize != null ? loadingIconSize : 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ))),
        ));
  }
}
