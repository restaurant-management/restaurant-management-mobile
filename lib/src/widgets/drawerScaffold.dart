import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../screens/profileScreen/ProfileDrawer.dart';
import '../screens/cartScreen/cartDrawer.dart';

class DrawerScaffold extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget appBar;
  final Widget bottomNavigationBar;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;

  const DrawerScaffold(
      {Key key,
      this.body,
      this.appBar,
      this.bottomNavigationBar,
      this.floatingActionButton,
      this.floatingActionButtonLocation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      backgroundColor: Theme.of(context).colorScheme.background,
      endDrawer: ProfileDrawer(),
      drawer: CartDrawer(),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
