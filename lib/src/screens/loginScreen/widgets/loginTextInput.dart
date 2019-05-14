import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginTextInput extends StatelessWidget {
  final String hint;
  final bool obscure;
  final IconData icon;
  final FormFieldValidator<String> validator;

  LoginTextInput({this.hint, this.obscure, this.icon, this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.white,
      obscureText: obscure,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
    );
  }
}
