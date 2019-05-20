import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:restaurant_management_mobile/src/blocs/profileScreenBloc/bloc.dart';
import 'package:restaurant_management_mobile/src/blocs/profileScreenBloc/state.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileScreenBloc _profileScreenBloc =
        BlocProvider.of<ProfileScreenBloc>(context);

    return BlocBuilder(
      bloc: _profileScreenBloc,
      builder: (BuildContext context, state) {
        if (state is ProfileScreenInitialize || state is ProfileScreenFetched)
          return ListView(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.contact_mail),
                title: Text(
                    state.currentUser.fullName ?? state.currentUser.username),
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text(state.currentUser.email),
              ),
              ListTile(
                leading: Icon(Icons.calendar_today),
                title: Text(state.currentUser.birthday != null
                    ? DateFormat('dd/MM/yyyy')
                        .format(state.currentUser.birthday)
                    : 'Chưa cập nhật'),
              ),
            ],
          );
      },
    );
  }
}
